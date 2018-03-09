Received: from eggs.gnu.org ([2001:4830:134:3::10]:33595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJ8i-0000aq-8f
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euJ8f-0003C2-1U
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:36:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euJ8e-0003Bv-RW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:36:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5BEDF406E8A4
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 14:36:52 +0000 (UTC)
References: <1520576005-27647-1-git-send-email-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92dfc791-1fe6-f421-000b-6d103235417a@redhat.com>
Date: Fri, 9 Mar 2018 08:36:47 -0600
MIME-Version: 1.0
In-Reply-To: <1520576005-27647-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 03/09/2018 12:13 AM, Thomas Huth wrote:
> "-net" is clearly a legacy option. Yet we still use it in almost all
> examples in the qemu documentation, and many other spots in the network
> chapter. We should make it less prominent that users are not lured into
> using it so often anymore. So instead of starting the network chapter with
> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
> everywhere, all the "-net" related documentation is now moved to the end
> of the chapter. The new "--nic" option is moved to the beginning of the
> chapter instead, with a new example that should demonstrate how "--nic"
> can be used to shortcut "--device" with "--netdev".
> And the examples in this chapter are changed to use the "--device" and
> "--netdev" options or "--nic" instead of "-net nic -net <backend>".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qemu-options.hx | 210 ++++++++++++++++++++++++++++----------------------------
>   1 file changed, 105 insertions(+), 105 deletions(-)
> 

> -@item -netdev user,id=@var{id}[,@var{option}][,@var{option}][,...]
> -@findex -netdev
> -@item -net user[,@var{option}][,@var{option}][,...]
> -Use the user mode network stack which requires no administrator
> +@item --nic [tap|bridge|user|l2tpv3|vde|netmap|vhost-user|socket][,...][,mac=macaddr][,model=mn]
> +
> +This option is a shortcut for configuring both, the on-board (default) guest

s/both,/both/

> +NIC hardware and the host network backend in one go. The host backend options
> +are the same as with the corresponding @option{--netdev} options below.
> +The guest NIC model can be set with @option{model=@var{modelname}}.
> +Use @option{model=help} to list the available device types.
> +The hardware MAC address can be set with @option{mac=@var{macaddr}}.
> +
> +The following two example do exactly the same, to show how @option{--nic} can
> +be used to shorten the command line length (note that the e1000 is the default
> +on i386, so the @option{model=e1000} parameter could even be omitted here, too):
> +@example
> +qemu-system-i386 --netdev user,id=n1,ipv6=off --device=e1000,netdev=n1,mac=52:54:98:76:54:32
> +qemu-system-i386 --nic user,ipv6=off,model=e1000,mac=52:54:98:76:54:32
> +@end example

Nice example.

> +
> +@item --nic none
> +Indicate that no network devices should be configured. It is used to override
> +the default configuration (default NIC with @option{--net user} backend) which
> +is activated if no other networking options are provided.
> +
> +@item --netdev user,id=@var{id}[,@var{option}][,@var{option}][,...]
> +@findex --netdev
> +Configure user mode host network backend which requires no administrator
>   privilege to run. Valid options are:
> @@ -2166,8 +2166,6 @@ or @file{C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS} (Windows NT/2000).
>   Then @file{@var{dir}} can be accessed in @file{\\smbserver\qemu}.
>   
>   Note that a SAMBA server must be installed on the host OS.
> -QEMU was tested successfully with smbd versions from Red Hat 9,
> -Fedora Core 3 and OpenSUSE 11.x.
>   

This change makes sense, but is somewhat unrelated to -net.  Worth 
splitting the patch?

>   @item hostfwd=[tcp|udp]:[@var{hostaddr}]:@var{hostport}-[@var{guestaddr}]:@var{guestport}
>   Redirect incoming TCP or UDP connections to the host port @var{hostport} to
> @@ -2182,7 +2180,7 @@ screen 0, use the following:
>   
>   @example
>   # on the host
> -qemu-system-i386 -net user,hostfwd=tcp:127.0.0.1:6001-:6000 [...]
> +qemu-system-i386 --nic user,hostfwd=tcp:127.0.0.1:6001-:6000

The trailing [...] makes sense here, why did you drop it?

>   # this host xterm should open in the guest X11 server
>   xterm -display :1
>   @end example
> @@ -2192,7 +2190,7 @@ the guest, use the following:
>   
>   @example
>   # on the host
> -qemu-system-i386 -net user,hostfwd=tcp::5555-:23 [...]
> +qemu-system-i386 --device e1000,netdev=n1 --netdev user,id=n1,hostfwd=tcp::5555-:23

and again.

Is it worth trying to use backslash-newline in long example lines, or 
are we okay with long lengths?

>   telnet localhost 5555
>   @end example
>   
> @@ -2211,7 +2209,7 @@ lifetime, like in the following example:
>   @example
>   # open 10.10.1.1:4321 on bootup, connect 10.0.2.100:1234 to it whenever
>   # the guest accesses it
> -qemu -net user,guestfwd=tcp:10.0.2.100:1234-tcp:10.10.1.1:4321 [...]
> +qemu-system-i386 --nic user,guestfwd=tcp:10.0.2.100:1234-tcp:10.10.1.1:4321
>   @end example

Again, the [...] seems like it is worth keeping.

>   
>   Or you can execute a command on every TCP connection established by the guest,
> @@ -2220,7 +2218,8 @@ so that QEMU behaves similar to an inetd process for that virtual server:
>   @example
>   # call "netcat 10.10.1.1 4321" on every TCP connection to 10.0.2.100:1234
>   # and connect the TCP stream to its stdin/stdout
> -qemu -net 'user,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
> +qemu-system-i386 --device e1000,netdev=n1 \
> +  --netdev 'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'

Ah, here you DID use a line break in a long example.


> -@item -netdev socket,id=@var{id}[,fd=@var{h}][,mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]]
> -@itemx -net socket[,vlan=@var{n}][,name=@var{name}][,fd=@var{h}][,mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]]
> +@item --netdev socket,id=@var{id}[,fd=@var{h}][,mcast=@var{maddr}:@var{port}[,localaddr=@var{addr}]]
>   
> -Create a VLAN @var{n} shared with another QEMU virtual
> -machines using a UDP multicast socket, effectively making a bus for
> -every QEMU with same multicast address @var{maddr} and @var{port}.
> +Configure a socket host network backend to shared the guest's network traffic

s/shared/share/

> +with another QEMU virtual machines using a UDP multicast socket, effectively
> +making a bus for every QEMU with same multicast address @var{maddr} and @var{port}.

> +
> +@item -net nic[,vlan=@var{n}][,netdev=@var{nd}][,macaddr=@var{mac}][,model=@var{type}] [,name=@var{name}][,addr=@var{addr}][,vectors=@var{v}]

Worth spelling this --net instead of -net?

> +@findex -net

We can have multiple @findex listings; should we list both @findex -net 
and @findex --net?

> +Legacy option to configure or create an on-board (or machine default) Network
> +Interface Card(NIC) and connect it either to the emulated hub port ("vlan")
> +with number @var{n} (@var{n} = 0 is the default), or to the netdev @var{nd}.
> +The NIC is an e1000 by default on the PC target. Optionally, the MAC address
> +can be changed to @var{mac}, the device address set to @var{addr} (PCI cards
> +only), and a @var{name} can be assigned for use in monitor commands.
> +Optionally, for PCI cards, you can specify the number @var{v} of MSI-X vectors
> +that the card should have; this option currently only affects virtio cards; set
> +@var{v} = 0 to disable MSI-X. If no @option{-net} option is specified, a single
> +NIC is created.  QEMU can emulate several different models of network card.
> +Use @code{-net nic,model=help} for a list of available devices for your target.
> +
> +@item -net user|tap|bridge|socket|l2tpv3|vde[,...][,vlan=@var{n}][,name=@var{name}]
> +Configure a host network backend (with the options corresponding to the same
> +@option{--netdev} option) and connect it to the emulated hub ("vlan") with the
> +number @var{n} (default is number 0). Use @var{name} to specify the name of the
> +hub port.
>   ETEXI
>   
>   STEXI
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
