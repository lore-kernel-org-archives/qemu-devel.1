Received: from eggs.gnu.org ([2001:4830:134:3::10]:41535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exz2E-0001Sv-7l
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1exz2B-0005zu-5t
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:57:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1exz2B-0005zN-0A
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 13:57:23 -0400
References: <20180314190814.22631-1-benjamin.drung@profitbricks.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd4aa247-740c-324f-5348-453af8b8a310@redhat.com>
Date: Mon, 19 Mar 2018 12:57:11 -0500
MIME-Version: 1.0
In-Reply-To: <20180314190814.22631-1-benjamin.drung@profitbricks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2 v3] slirp: Add classless static routes
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

On 03/14/2018 02:08 PM, Benjamin Drung wrote:
> This patch will allow the user to specify classless static routes for
> the replies from the built-in DHCP server, for example:

This mail was sent as a 2/2, but with no In-Reply-To: header pointing to 
a 0/2 cover letter.  Am I missing something?

> 
>    qemu --net user,route=10.0.2.0/24,route=192.168.0.0/16 [...]
> 
> The QMP schema for the "route" option is ['str'], because the opts
> visitor code only supports lists with a single mandatory scalar member.
> The option "ipv6-net" takes two pieces and is split in net_client_init()
> into "ipv6-prefix" and "ipv6-prefixlen" before calling
> visit_type_Netdev()/visit_type_NetLegacy(). But that logic cannot be
> used for the "route" option, because there is no intermediate format to
> store the split parts for further processing without overhauling the
> visitor code. Once the opts visitor supports lists with multiple
> members, please update the QMP schema to:
> 
> { 'struct': 'RouteEntry',
>    'data': {
>      'subnet': 'str',
>      'mask_width': 'uint8',
>      '*gateway': 'str' } }
> [...]
> 'route': [ 'RouteEntry' ]

Sadly, once the QMP is released, we don't want to be changing it  (other 
than perhaps by use of an 'alternate' that allows both old and new 
styles in parallel), so that we don't break clients expecting the 
original way to work.  It may be better to bite the bullet and fix the 
command line parser to do what we need (Markus has been doing lots of 
work in this area already, so it may just be a matter of waiting for him 
to return to work from his leave).

I'm also afraid that since this patch wasn't picked up in any of the 
pull requests for soft freeze, but at the same time it feels like a new 
feature, that it's better delaying it to 2.13 anyways.  (But that may be 
a good thing, if it lets us fix the problems with the command line 
parsing limitations)


> +++ b/qapi/net.json
> @@ -163,6 +163,9 @@
>   # @domainname: guest-visible domain name of the virtual nameserver
>   #              (since 2.12)
>   #
> +# @route: guest-visible static classless route of the virtual nameserver
> +#         (since 2.12)

If this still takes a straight string instead of a proper struct, then 
you at least need to document the syntax supported in that string.  And 
again, I'm thinking 2.12 is going to be premature, so your next spin of 
this patch should use 2.13.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
