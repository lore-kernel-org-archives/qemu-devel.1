Received: from eggs.gnu.org ([2001:4830:134:3::10]:46007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gMqEW-0003vQ-0d
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 03:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gMqES-0005YG-S3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 03:09:08 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gMqES-0005Xl-Ke
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 03:09:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	wAE892ma061500
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:09:02 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by aserp2120.oracle.com with ESMTP id 2nr7cs1qhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:09:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAE88wcA015318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:08:59 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAE88vGm021555
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 08:08:58 GMT
References: <20181113115704.2025-1-kraxel@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <27cf5bbd-8876-3fc0-92ee-aecadcba6bbd@oracle.com>
Date: Wed, 14 Nov 2018 08:08:48 +0000
MIME-Version: 1.0
In-Reply-To: <20181113115704.2025-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/bt: drop bluetooth keyboard emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 13/11/2018 11:57, Gerd Hoffmann wrote:
> Broken (segfaults on first keypress, probably since 2.1) and apparently unused.
> 
> Reproducer:
>    qemu -usb -device usb-bt-dongle -bt hci,vlan=0 -bt device:keyboard
> 
> Stacktrace:
>    #0  0x00005606841f7363 in bt_hid_send_data (ch=0x0, type=1, data=0x560686986400 "", len=8)
>        at /home/kraxel/projects/qemu/hw/bt/hid.c:178
>    #1  0x00005606841f7afa in bt_hid_datain (hs=0x560686985eb8)
>        at /home/kraxel/projects/qemu/hw/bt/hid.c:387
>    #2  0x00005606842643d8 in hid_keyboard_event (dev=0x560686985eb8, src=0x5606869b9c10, evt=0x5606868772a0)
>        at /home/kraxel/projects/qemu/hw/input/hid.c:245
>    #3  0x00005606843eab39 in qemu_input_event_send_impl (src=0x5606869b9c10, evt=0x5606868772a0)
>        at /home/kraxel/projects/qemu/ui/input.c:346
>    #4  0x00005606843caadd in replay_input_event (src=0x5606869b9c10, evt=0x5606868772a0)
>        at /home/kraxel/projects/qemu/replay/replay-input.c:128
>    #5  0x00005606843eabf4 in qemu_input_event_send (src=0x5606869b9c10, evt=0x5606868772a0)
>        at /home/kraxel/projects/qemu/ui/input.c:375
>    #6  0x00005606843ead43 in qemu_input_event_send_key (src=0x5606869b9c10, key=0x560686819e50, down=true) at /home/kraxel/projects/qemu/ui/input.c:419
>    #7  0x00005606843eae23 in qemu_input_event_send_key_qcode (src=0x5606869b9c10, q=Q_KEY_CODE_RET, down=true)
>        at /home/kraxel/projects/qemu/ui/input.c:441
>    [ ... snip ... ]
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

One question below, otherwise

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>

> ---
>   include/hw/bt.h     |   3 -
>   hw/bt/hid.c         | 554 ----------------------------------------------------
>   vl.c                |  34 +---
>   hw/bt/Makefile.objs |   3 +-
>   qemu-doc.texi       |   6 +-
>   qemu-options.hx     |   9 -
>   6 files changed, 3 insertions(+), 606 deletions(-)
>   delete mode 100644 hw/bt/hid.c
> 

[ snip]

> diff --git a/qemu-options.hx b/qemu-options.hx
> index 38c7a978c1..48885cdca8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx

Is this extra removal needed too?

@@ -2757,9 +2757,7 @@ DEF("bt", HAS_ARG, QEMU_OPTION_bt, \
      "-bt hci[,vlan=n]\n" \
      "                emulate a standard HCI in virtual scatternet 'n'\n" \
      "-bt vhci[,vlan=n]\n" \
-    "                add host computer to virtual scatternet 'n' using 
VHCI\n" \
-    "-bt device:dev[,vlan=n]\n" \
-    "                emulate a bluetooth device 'dev' in scatternet 'n'\n",
+    "                add host computer to virtual scatternet 'n' using 
VHCI\n", \
      QEMU_ARCH_ALL)
  STEXI
  @item -bt hci[...]




> @@ -2804,15 +2804,6 @@ be used as following:
>   qemu-system-i386 [...OPTIONS...] -bt hci,vlan=5 -bt vhci,vlan=5
>   @end example
>   
> -@item -bt device:@var{dev}[,vlan=@var{n}]
> -Emulate a bluetooth device @var{dev} and place it in network @var{n}
> -(default @code{0}).  QEMU can only emulate one type of bluetooth devices
> -currently:
> -
> -@table @option
> -@item keyboard
> -Virtual wireless keyboard implementing the HIDP bluetooth profile.
> -@end table
>   ETEXI
>   
>   STEXI
> 
