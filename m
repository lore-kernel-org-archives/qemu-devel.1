Received: from eggs.gnu.org ([2001:4830:134:3::10]:43895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu1UW-0005az-5n
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:46:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eu1UT-000786-3I
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:46:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eu1US-00077X-T5
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:46:13 -0500
References: <20180304210608.vn33p6pn7t2nsxv4@var.youpi.perso.aquilenet.fr>
	<20180308185743.3408-1-benjamin.drung@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88890d90-4dc6-bac3-4591-f29a271181df@redhat.com>
Date: Thu, 8 Mar 2018 13:46:00 -0600
MIME-Version: 1.0
In-Reply-To: <20180308185743.3408-1-benjamin.drung@profitbricks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Benjamin Drung <benjamin.drung@profitbricks.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@gnu.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org

On 03/08/2018 12:57 PM, Benjamin Drung wrote:
> This patch will allow the user to specify classless static routes for
> the replies from the built-in DHCP server.
> 
> Signed-off-by: Benjamin Drung <benjamin.drung@profitbricks.com>
> ---

For future patches, when sending a v2, it's best to document here (after 
the --- separator) what changed from v1.  It's also a good idea to send 
a fresh thread rather than tying your v2 in-reply-to your v1, so that it 
doesn't get buried in an old conversation.

More submission hints at https://wiki.qemu.org/Contribute/SubmitAPatch

>   net/slirp.c      | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
>   qapi/net.json    |  4 ++++
>   qemu-options.hx  | 14 +++++++++++-
>   slirp/bootp.c    | 20 +++++++++++++++++
>   slirp/bootp.h    |  2 ++
>   slirp/libslirp.h |  9 +++++++-
>   slirp/slirp.c    |  7 +++++-
>   slirp/slirp.h    |  2 ++
>   8 files changed, 120 insertions(+), 6 deletions(-)

Reviewing just the QMP interface:


> +++ b/qapi/net.json
> @@ -163,6 +163,9 @@
>   # @domainname: guest-visible domain name of the virtual nameserver
>   #              (since 2.12)
>   #
> +# @route: guest-visible static classless route of the virtual nameserver
> +#         (since 2.12)
> +#
>   # @ipv6-prefix: IPv6 network prefix (default is fec0::) (since
>   #               2.6). The network prefix is given in the usual
>   #               hexadecimal IPv6 address notation.
> @@ -201,6 +204,7 @@
>       '*dns':       'str',
>       '*dnssearch': ['String'],
>       '*domainname': 'str',
> +    '*route':     ['String'],

I know we've used ['String'] for previous members, but that's rather 
heavyweight - it transmits over QMP as:

"dnssearch": [ { "str": "foo" }, { "str": "bar" } ]

Nicer is ['str'], which transmits as:

"route": [ "foo", "bar" ]

so the question boils down to whether cross-member consistency is more 
important than making your additions concise.

> +++ b/qemu-options.hx
> @@ -1904,7 +1904,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>       "         [,ipv6[=on|off]][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
>       "         [,restrict=on|off][,hostname=host][,dhcpstart=addr]\n"
>       "         [,dns=addr][,ipv6-dns=addr][,dnssearch=domain][,domainname=domain]\n"
> -    "         [,tftp=dir][,bootfile=f][,hostfwd=rule][,guestfwd=rule]"
> +    "         [,route=addr/mask[:gateway]][,tftp=dir][,bootfile=f][,hostfwd=rule][,guestfwd=rule]"

Urgh - your QMP interface HAS to be further parsed to get to the useful 
information.  While it's nice to have compact syntax on the command 
line, it is really worth thinking about making information easier to 
consume (that is, NO further parsing required once the information is in 
JSON format).  Would it be any better to send things over the wire as:

"route": [ { "addr": "...", "mask": 24, "gateway": "..." } ]

instead of cramming all the information into a single string?  But based 
on the way this also maps to the command line, you may not have a choice 
without a lot more code complexity.

>   #ifndef _WIN32
>                                                "[,smb=dir[,smbserver=addr]]\n"
>   #endif
> @@ -2137,6 +2137,18 @@ qemu -net user,dnssearch=mgmt.example.org,dnssearch=example.org [...]
>   @item domainname=@var{domain}
>   Specifies the client domain name reported by the built-in DHCP server.
>   
> +@item route=@var{addr}/@var{mask}[:@var{gateway}]
> +Provides an entry for the classless static routes list sent by the built-in
> +DHCP server. More than one route can be transmitted by specifying
> +this option multiple times. If supported, this will cause the guest to
> +automatically set the given static routes instead of the given default gateway.
> +If @var{gateway} is not specified, the default gateway will be used.
> +
> +Example:
> +@example
> +qemu -net user,route=10.0.2.0/24,route=192.168.0.0/16 [...]
> +@end example

Can we please spell that '--net', along the lines of 
https://wiki.qemu.org/BiteSizedTasks#Consistent_option_usage_in_documentation

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
