Received: from eggs.gnu.org ([209.51.188.92]:36499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjIzC-0002pZ-U0
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjIzB-0004VP-Ue
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:18:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjIzB-0004U7-Kc
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 02:18:09 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B26397CDE4
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 07:18:08 +0000 (UTC)
References: <20181115143124.19234-1-pbonzini@redhat.com>
	<20181115143124.19234-4-pbonzini@redhat.com>
	<13a533b2-89da-683c-0bae-02d7597c9032@redhat.com>
	<20190114225028-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c45d1790-5f4b-73bd-ea18-468dd39916b5@redhat.com>
Date: Tue, 15 Jan 2019 08:18:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190114225028-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] vhost-net: compile it for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, jasowang@redhat.com

On 15/01/19 04:50, Michael S. Tsirkin wrote:
> On Thu, Nov 15, 2018 at 07:42:20PM +0100, Paolo Bonzini wrote:
>> On 15/11/2018 15:31, Paolo Bonzini wrote:
>>> Currently vhost-net is compiled only for KVM-enabled targets.  This is
>>> not needed anymore because ioeventfd is supported and emulated by the
>>> memory core.  Compile it and vhost-user-test for all targets.
>>> While at it, fix the annoying typo CONFIG_VHOST_NET_USED.
>>>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  configure              | 13 +++++--------
>>>  include/exec/poison.h  |  1 -
>>>  net/net.c              |  2 +-
>>>  tests/Makefile.include |  5 +----
>>>  4 files changed, 7 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/configure b/configure
>>> index 5b1d83ea26..d8317e1832 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -6512,8 +6512,11 @@ fi
>>>  if test "$vhost_scsi" = "yes" ; then
>>>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>>>  fi
>>> -if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
>>> -  echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
>>> +if test "$vhost_net" = "yes" ; then
>>> +  echo "CONFIG_VHOST_NET=y" >> $config_host_mak
>>> +  if test "$vhost_user" = "yes"; then
>>> +    echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
>>> +  fi
>>>  fi
>>>  if test "$vhost_crypto" = "yes" ; then
>>>    echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
>>> @@ -7275,12 +7278,6 @@ if supported_xen_target $target; then
>>>  fi
>>>  if supported_kvm_target $target; then
>>>      echo "CONFIG_KVM=y" >> $config_target_mak
>>> -    if test "$vhost_net" = "yes" ; then
>>> -        echo "CONFIG_VHOST_NET=y" >> $config_target_mak
>>> -        if test "$vhost_user" = "yes" ; then
>>> -            echo "CONFIG_VHOST_USER_NET_TEST_$target_name=y" >> $config_host_mak
>>> -        fi
>>> -    fi
>>>  fi
>>>  if supported_hax_target $target; then
>>>      echo "CONFIG_HAX=y" >> $config_target_mak
>>> diff --git a/include/exec/poison.h b/include/exec/poison.h
>>> index 32d53789f8..b158632791 100644
>>> --- a/include/exec/poison.h
>>> +++ b/include/exec/poison.h
>>> @@ -85,7 +85,6 @@
>>>  #pragma GCC poison CONFIG_XTENSA_DIS
>>>  
>>>  #pragma GCC poison CONFIG_LINUX_USER
>>> -#pragma GCC poison CONFIG_VHOST_NET
>>>  #pragma GCC poison CONFIG_KVM
>>>  #pragma GCC poison CONFIG_SOFTMMU
>>>  
>>> diff --git a/net/net.c b/net/net.c
>>> index 07c194a8f6..95a74add6c 100644
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
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index fb0b449c02..03a64ce9c8 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -204,10 +204,7 @@ check-qtest-i386-$(CONFIG_USB_XHCI_NEC) += tests/usb-hcd-xhci-test$(EXESUF)
>>>  check-qtest-i386-y += tests/cpu-plug-test$(EXESUF)
>>>  check-qtest-i386-y += tests/q35-test$(EXESUF)
>>>  check-qtest-i386-y += tests/vmgenid-test$(EXESUF)
>>> -check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) += tests/vhost-user-test$(EXESUF)
>>> -ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
>>> -check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) += tests/vhost-user-test$(EXESUF)
>>> -endif
>>> +check-qtest-i386-$(CONFIG_VHOST_NET_USER) += tests/vhost-user-test$(EXESUF)
>>>  check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-swtpm-test$(EXESUF)
>>>  check-qtest-i386-$(CONFIG_TPM_CRB) += tests/tpm-crb-test$(EXESUF)
>>>  check-qtest-i386-$(CONFIG_TPM_TIS) += tests/tpm-tis-swtpm-test$(EXESUF)
>>>
>>
>> FWIW this is unfortunately not that simple.  Patchew will surely notice.
>> :)  I will post v2 when I get reviews for everything else.
> 
> So with the header split this can now go in I guess?
> Want to repost?

Yes.  I'll do it later today after testing.

Paolo
