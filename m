Received: from eggs.gnu.org ([2001:4830:134:3::10]:55466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1ewBkl-0007pw-HY
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benjamin.drung@profitbricks.com>) id 1ewBkh-0007ID-C0
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:07:59 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:53742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <benjamin.drung@profitbricks.com>)
	id 1ewBkh-0007Ha-2l
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 15:07:55 -0400
Received: by mail-wm0-x22c.google.com with SMTP id e194so6096532wmd.3
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 12:07:54 -0700 (PDT)
Message-ID: <1521054471.6268.26.camel@profitbricks.com>
From: Benjamin Drung <benjamin.drung@profitbricks.com>
Date: Wed, 14 Mar 2018 20:07:51 +0100
In-Reply-To: <e5af8c70-e6e4-682a-bbd7-6b914b813737@redhat.com>
References: <20180304210608.vn33p6pn7t2nsxv4@var.youpi.perso.aquilenet.fr>
	<20180308185743.3408-1-benjamin.drung@profitbricks.com>
	<88890d90-4dc6-bac3-4591-f29a271181df@redhat.com>
	<1520539656.6051.11.camel@profitbricks.com>
	<e5af8c70-e6e4-682a-bbd7-6b914b813737@redhat.com>
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

Am Donnerstag, den 08.03.2018, 14:21 -0600 schrieb Eric Blake:
> On 03/08/2018 02:07 PM, Benjamin Drung wrote:
> > Am Donnerstag, den 08.03.2018, 13:46 -0600 schrieb Eric Blake:
> > > On 03/08/2018 12:57 PM, Benjamin Drung wrote:
> > > >        '*dnssearch': ['String'],
> > > >        '*domainname': 'str',
> > > > +    '*route':     ['String'],
> > > 
> > > I know we've used ['String'] for previous members, but that's
> > > rather
> > > heavyweight - it transmits over QMP as:
> > > 
> > > "dnssearch": [ { "str": "foo" }, { "str": "bar" } ]
> > > 
> > > Nicer is ['str'], which transmits as:
> > > 
> > > "route": [ "foo", "bar" ]
> > > 
> > > so the question boils down to whether cross-member consistency is
> > > more
> > > important than making your additions concise.
> > 
> > Agreed that ['str'] is nicer. I will update the patch.
> 
> The problem is that ['str'] might not work easily for the command
> line 
> glue; I'm more familiar with how QMP exposes things than with the 
> command line parsing, and Markus, who is trying to improve command
> line 
> parsing to share more common infrastructure with QMP, might have
> better 
> comments on the topic, except that he's on leave for a few weeks and 
> won't respond until after 2.12 is frozen.  Using ['String'] for 
> consistency is therefore okay, if you can't get ['str'] working
> quickly.

['str'] works and was easily changeable.

> > > > @@ -1904,7 +1904,7 @@ DEF("netdev", HAS_ARG,
> > > > QEMU_OPTION_netdev,
> > > >        "         [,ipv6[=on|off]][,ipv6-net=addr[/int]][,ipv6-
> > > > host=addr]\n"
> 
> Here's an example where we made the command line smart.  ipv6-net
> takes 
> TWO pieces of information: addr/int; on the QMP side, we spelled it 
> '*ipv6-prefix':'str' + 'ipv6-prefixlen':'int'.  So somewhere in the 
> command line parsing code for --net (which I'm less familiar with), 
> there is some glue code taking the compact representation and
> splitting 
> it into the more verbose but more direct QMP representation - well,
> that 
> is, if we are converting it into QMP form at all (part of the problem
> is 
> that our command line and runtime control don't always share code, 
> although we're trying to get better at that).

The split is done net_client_init() before iterating over the options.
This is equivalent to having following command line parameter:

  [,ipv6-prefix=addr][,ipv6-prefixlen=int]

instead of

  [,ipv6-net=addr[/int]]

> > > > +    "         [,route=addr/mask[:gateway]][,tftp=dir][,bootfil
> > > > e=f]
> > > > [,hostfwd=rule][,guestfwd=rule]"
> > > 
> > > Urgh - your QMP interface HAS to be further parsed to get to the
> > > useful
> > > information.  While it's nice to have compact syntax on the
> > > command
> > > line, it is really worth thinking about making information easier
> > > to
> > > consume (that is, NO further parsing required once the
> > > information is
> > > in
> > > JSON format).  Would it be any better to send things over the
> > > wire
> > > as:
> > > 
> > > "route": [ { "addr": "...", "mask": 24, "gateway": "..." } ]
> > 
> > That's looks good.
> 
> Okay, doing that would mean using something like:
> 
> { 'struct': 'RouteEntry', 'data': { 'addr': 'str', '*mask': 'int', 
> '*gateway': 'str' } }
> ...
> 'route': [ 'RouteEntry' ]
> 
> (but reuse, rather than inventing a new type, if one of the existing
> QMP 
> types already resembles what I proposed for RouteEntry)
> 
> The command line can still use route=addr/mask:gateway syntax, parse
> it 
> down into components, then compile the QMP array of already-parsed 
> structs (rather than making QMP take a direct ['String'] that still 
> needs further parsing).  It may take more glue code, but the idea is 
> that all the glue code should live on the front end, so that the QMP 
> backend should be easy to work with.

The problem is that the opts visitor code only supports lists with a
single mandatory scalar member. Bigger changes are needed to support
splitting 'route'. I have looked into the code for several hours, but
found no simple and non-ugly way to add the splitting without major
changes to the code. I am willing to adapt the patch if someone changes
the opts visitor to support lists with multiple members.

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
