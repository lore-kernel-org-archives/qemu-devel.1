Received: from eggs.gnu.org ([2001:4830:134:3::10]:40625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRPka-0004Gp-3L
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRPkV-0002DJ-2N
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:53:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRPkU-0002D7-Qt
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 17:53:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so20673912wrx.9
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 14:53:02 -0800 (PST)
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
	<1543238443-4993-3-git-send-email-pbonzini@redhat.com>
	<de2b36ae-7445-2a85-7187-7748d5f77baa@redhat.com>
	<20181126174340-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <900df125-4699-61ad-c604-9f433fa7f330@redhat.com>
Date: Mon, 26 Nov 2018 23:52:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181126174340-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/5] vhost-net-user: add stubs for when no
 virtio-net device is present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 26/11/18 23:43, Michael S. Tsirkin wrote:
> On Mon, Nov 26, 2018 at 05:45:47PM +0100, Philippe Mathieu-Daudé wrote:
>> On 26/11/18 14:20, Paolo Bonzini wrote:
>>> hw/net/vhost_net.c needs functions that are declared in net/vhost-user.c: the
>>> vhost-user code is always compiled into QEMU, only the constructor
>>> net_init_vhost_user is unreachable.  Also, net/vhost-user.c needs functions
>>> declared in hw/virtio/vhost-stub.c even if no virtio device exists.
>>>
>>> Break this dependency.  First, add a minimal version of net/vhost-user.c,
>>> with no functionality and no dependency on vhost code.  Second, #ifdef out
>>> the calls back to net/vhost-user.c from hw/net/vhost_net.c.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> whic hosts/targets and how did you test exactly?

This series is a buildsys refactor; after reviewing I building tested
linux (KVM) and win32 (default, --enable-vhost-user,
--enable-vhost-kernel). I did not test on BSD.
I did not test the running vhost code, simply assumed linking is enough.

> 
>>> ---
>>>  configure             |  2 +-
>>>  hw/net/vhost_net.c    |  4 ++++
>>>  net/Makefile.objs     |  4 +++-
>>>  net/net.c             |  2 +-
>>>  net/vhost-user-stub.c | 23 +++++++++++++++++++++++
>>>  5 files changed, 32 insertions(+), 3 deletions(-)
>>>  create mode 100644 net/vhost-user-stub.c
>>>
>>> diff --git a/configure b/configure
>>> index 0a3c6a7..cda17ef 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -6513,7 +6513,7 @@ if test "$vhost_scsi" = "yes" ; then
>>>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>>>  fi
>>>  if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
>>> -  echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
>>> +  echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
>>>  fi
>>>  if test "$vhost_crypto" = "yes" ; then
>>>    echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>>> index b901306..fe6202a 100644
>>> --- a/hw/net/vhost_net.c
>>> +++ b/hw/net/vhost_net.c
>>> @@ -193,6 +193,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>>>      }
>>>  
>>>      /* Set sane init value. Override when guest acks. */
>>> +#ifdef CONFIG_VHOST_USER
>>>      if (net->nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
>>>          features = vhost_user_get_acked_features(net->nc);
>>>          if (~net->dev.features & features) {
>>> @@ -202,6 +203,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
>>>              goto fail;
>>>          }
>>>      }
>>> +#endif
>>>  
>>>      vhost_net_ack_features(net, features);
>>>  
>>> @@ -413,10 +415,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>>>      case NET_CLIENT_DRIVER_TAP:
>>>          vhost_net = tap_get_vhost_net(nc);
>>>          break;
>>> +#ifdef CONFIG_VHOST_NET_USER
>>>      case NET_CLIENT_DRIVER_VHOST_USER:
>>>          vhost_net = vhost_user_get_vhost_net(nc);
>>>          assert(vhost_net);
>>>          break;
>>> +#endif
>>>      default:
>>>          break;
>>>      }
>>> diff --git a/net/Makefile.objs b/net/Makefile.objs
>>> index b2bf88a..df2b409 100644
>>> --- a/net/Makefile.objs
>>> +++ b/net/Makefile.objs
>>> @@ -3,7 +3,9 @@ common-obj-y += socket.o
>>>  common-obj-y += dump.o
>>>  common-obj-y += eth.o
>>>  common-obj-$(CONFIG_L2TPV3) += l2tpv3.o
>>> -common-obj-$(CONFIG_POSIX) += vhost-user.o
>>> +common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET_USER)) += vhost-user.o
>>> +common-obj-$(call land,$(call lnot,$(CONFIG_VIRTIO_NET)),$(CONFIG_VHOST_NET_USER)) += vhost-user-stub.o
>>> +common-obj-$(CONFIG_ALL) += vhost-user-stub.o
>>>  common-obj-$(CONFIG_SLIRP) += slirp.o
>>>  common-obj-$(CONFIG_VDE) += vde.o
>>>  common-obj-$(CONFIG_NETMAP) += netmap.o
>>> diff --git a/net/net.c b/net/net.c
>>> index 07c194a..95a74ad 100644
>>> --- a/net/net.c
>>> +++ b/net/net.c
>>> @@ -955,7 +955,7 @@ static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
>>>          [NET_CLIENT_DRIVER_BRIDGE]    = net_init_bridge,
>>>  #endif
>>>          [NET_CLIENT_DRIVER_HUBPORT]   = net_init_hubport,
>>> -#ifdef CONFIG_VHOST_NET_USED
>>> +#ifdef CONFIG_VHOST_NET_USER
>>>          [NET_CLIENT_DRIVER_VHOST_USER] = net_init_vhost_user,
>>>  #endif
>>>  #ifdef CONFIG_L2TPV3
>>> diff --git a/net/vhost-user-stub.c b/net/vhost-user-stub.c
>>> new file mode 100644
>>> index 0000000..52ab4e1
>>> --- /dev/null
>>> +++ b/net/vhost-user-stub.c
>>> @@ -0,0 +1,23 @@
>>> +/*
>>> + * vhost-user-stub.c
>>> + *
>>> + * Copyright (c) 2018 Red Hat, Inc.
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>> + * See the COPYING file in the top-level directory.
>>> + *
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "clients.h"
>>> +#include "net/vhost_net.h"
>>> +#include "net/vhost-user.h"
>>> +#include "qemu/error-report.h"
>>> +#include "qapi/error.h"
>>> +
>>> +int net_init_vhost_user(const Netdev *netdev, const char *name,
>>> +                        NetClientState *peer, Error **errp)
>>> +{
>>> +    error_setg(errp, "vhost-user requires frontend driver virtio-net-*");
>>> +    return -1;
>>> +}
>>>
