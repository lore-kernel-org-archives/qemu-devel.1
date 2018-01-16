Received: from eggs.gnu.org ([2001:4830:134:3::10]:37882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKMg-0004sB-8U
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebKMb-0007DA-Ao
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:04:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ebKMb-0007Cs-4O
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 01:04:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 04B5C552F1
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:04:48 +0000 (UTC)
References: <1516045855-27146-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c3deae0c-688c-13eb-f2ab-9af26899a289@redhat.com>
Date: Tue, 16 Jan 2018 14:04:43 +0800
MIME-Version: 1.0
In-Reply-To: <1516045855-27146-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] net: Allow hubports to connect to other
 netdevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2018=E5=B9=B401=E6=9C=8816=E6=97=A5 03:50, Thomas Huth wrote:
> QEMU can emulate hubs to connect NICs and netdevs. This is currently
> primarily used for the mis-named 'vlan' feature of the networking
> subsystem. Now the 'vlan' feature has been marked as deprecated, since
> its name is rather confusing and the users often rather mis-configure
> their network when trying to use it. But while the 'vlan' parameter
> should be removed at one point in time, the basic idea of emulating
> a hub in QEMU is still good: It's useful for bundling up the output of
> multiple NICs into one single l2tp netdev for example.
>
> Now to be able to use the hubport feature without 'vlan's, there is one
> missing piece: The possibility to connect a hubport to a netdev, too.
> This patch adds this possibility by introducing a new "netdev=3D..."
> parameter to the hubports.
>
> To bundle up the output of multiple NICs into one socket netdev, you ca=
n
> now run QEMU with these parameters for example:
>
> qemu-system-ppc64 ... -netdev socket,id=3Ds1,connect=3D:11122 \
>      -netdev hubport,hubid=3D1,id=3Dh1,netdev=3Ds1 \
>      -netdev hubport,hubid=3D1,id=3Dh2 -device e1000,netdev=3Dh2 \
>      -netdev hubport,hubid=3D1,id=3Dh3 -device virtio-net-pci,netdev=3D=
h3
>
> For using the socket netdev, you have got to start another QEMU as the
> receiving side first, for example with network dumping enabled:
>
> qemu-system-x86_64 -M isapc -netdev socket,id=3Ds0,listen=3D:11122 \
>      -device ne2k_isa,netdev=3Ds0 \
>      -object filter-dump,id=3Df1,netdev=3Ds0,file=3D/tmp/dump.dat
>
> After the ppc64 guest tried to boot from both NICs, you can see in the
> dump file (using Wireshark, for example), that the output of both NICs
> (the e1000 and the virtio-net-pci) has been successfully transfered
> via the socket netdev in this case.
>
> Suggested-by: Paolo Bonzini<pbonzini@redhat.com>
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   v2: Set up peer via qemu_new_net_client() instead of duplicating the
>       code to do this in net_init_hubport()

Applied.

Thanks
