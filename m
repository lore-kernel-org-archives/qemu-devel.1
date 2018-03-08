Received: from eggs.gnu.org ([2001:4830:134:3::10]:51167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1eu1pI-0002Z7-5C
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1eu1pE-0002X2-0v
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:07:44 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:40061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <benjamin.drung@profitbricks.com>)
	id 1eu1pD-0002Vs-NE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 15:07:39 -0500
Received: by mail-wr0-x22f.google.com with SMTP id o76so6913809wrb.7
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 12:07:39 -0800 (PST)
Message-ID: <1520539656.6051.11.camel@profitbricks.com>
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Thu, 08 Mar 2018 21:07:36 +0100
In-Reply-To: <88890d90-4dc6-bac3-4591-f29a271181df@redhat.com>
References: <20180304210608.vn33p6pn7t2nsxv4@var.youpi.perso.aquilenet.fr>
	<20180308185743.3408-1-benjamin.drung@profitbricks.com>
	<88890d90-4dc6-bac3-4591-f29a271181df@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2 v2] slirp: Add classless static routes
 support to DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@gnu.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org

Am Donnerstag, den 08.03.2018, 13:46 -0600 schrieb Eric Blake:
> On 03/08/2018 12:57 PM, Benjamin Drung wrote:
> > This patch will allow the user to specify classless static routes
> > for
> > the replies from the built-in DHCP server.
> > 
> > Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
> > ---
> 
> For future patches, when sending a v2, it's best to document here
> (after 
> the --- separator) what changed from v1.  It's also a good idea to
> send 
> a fresh thread rather than tying your v2 in-reply-to your v1, so that
> it 
> doesn't get buried in an old conversation.
> 
> More submission hints at https://wiki.qemu.org/Contribute/SubmitAPatch

Thanks. I will do that with the next iteration. Patch v2 addressed all
remarks from Samuel Thibault.

> > +++ b/qapi/net.json
> > @@ -163,6 +163,9 @@
> >   # @domainname: guest-visible domain name of the virtual
> > nameserver
> >   #              (since 2.12)
> >   #
> > +# @route: guest-visible static classless route of the virtual
> > nameserver
> > +#         (since 2.12)
> > +#
> >   # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
> >   #               2.6). The network prefix is given in the usual
> >   #               hexadecimal IPv6 address notation.
> > @@ -201,6 +204,7 @@
> >       '*dns':       'str',
> >       '*dnssearch': ['String'],
> >       '*domainname': 'str',
> > +    '*route':     ['String'],
> 
> I know we've used ['String'] for previous members, but that's rather 
> heavyweight - it transmits over QMP as:
> 
> "dnssearch": [ { "str": "foo" }, { "str": "bar" } ]
> 
> Nicer is ['str'], which transmits as:
> 
> "route": [ "foo", "bar" ]
> 
> so the question boils down to whether cross-member consistency is
> more 
> important than making your additions concise.

Agreed that ['str'] is nicer. I will update the patch.

> > +++ b/qemu-options.hx
> > @@ -1904,7 +1904,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> >       "         [,ipv6[=on|off]][,ipv6-net=addr[/int]][,ipv6-
> > host=addr]\n"
> >       "         [,restrict=on|off][,hostname=host][,dhcpstart=addr]
> > \n"
> >       "         [,dns=addr][,ipv6-
> > dns=addr][,dnssearch=domain][,domainname=domain]\n"
> > -    "         [,tftp=dir][,bootfile=f][,hostfwd=rule][,guestfwd=ru
> > le]"
> > +    "         [,route=addr/mask[:gateway]][,tftp=dir][,bootfile=f]
> > [,hostfwd=rule][,guestfwd=rule]"
> 
> Urgh - your QMP interface HAS to be further parsed to get to the
> useful 
> information.  While it's nice to have compact syntax on the command 
> line, it is really worth thinking about making information easier to 
> consume (that is, NO further parsing required once the information is
> in 
> JSON format).  Would it be any better to send things over the wire
> as:
> 
> "route": [ { "addr": "...", "mask": 24, "gateway": "..." } ]

That's looks good.

> instead of cramming all the information into a single string?  But
> based 
> on the way this also maps to the command line, you may not have a
> choice 
> without a lot more code complexity.

Can you point me to an example where similar parsing is done?

> >   #ifndef _WIN32
> >                                                "[,smb=dir[,smbserve
> > r=addr]]\n"
> >   #endif
> > @@ -2137,6 +2137,18 @@ qemu -net
> > user,dnssearch=mgmt.example.org,dnssearch=example.org [...]
> >   @item domainname=@var{domain}
> >   Specifies the client domain name reported by the built-in DHCP
> > server.
> >   
> > +@item route=@var{addr}/@var{mask}[:@var{gateway}]
> > +Provides an entry for the classless static routes list sent by the
> > built-in
> > +DHCP server. More than one route can be transmitted by specifying
> > +this option multiple times. If supported, this will cause the
> > guest to
> > +automatically set the given static routes instead of the given
> > default gateway.
> > +If @var{gateway} is not specified, the default gateway will be
> > used.
> > +
> > +Example:
> > +@example
> > +qemu -net user,route=10.0.2.0/24,route=192.168.0.0/16 [...]
> > +@end example
> 
> Can we please spell that '--net', along the lines of 
> https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_docum
> entation

I can change it, but then the documentation is inconsistent. There
are 75 lines with '-net' in qemu-options.hx, but only two lines
with '--net'.

-- 
Benjamin Drung
System Developer
Debian & Ubuntu Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Email: benjamin.drung@profitbricks.com
URL: https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Geschäftsführer: Achim Weiss, Matthias Steinberg
