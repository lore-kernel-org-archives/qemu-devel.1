Received: from eggs.gnu.org ([2001:4830:134:3::10]:59688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoCO-0006Eo-2w
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoCJ-00041b-3w
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:30:40 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoCI-00041L-W7
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:30:35 -0500
Received: by mail-qt0-x241.google.com with SMTP id a16so11661470qtj.3
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 03:30:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171210063819.14892-1-peterx@redhat.com>
	<20171210063819.14892-6-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d3c1162d-5a53-d93d-9319-1f4df427dcd6@amsat.org>
Date: Fri, 15 Dec 2017 08:30:30 -0300
MIME-Version: 1.0
In-Reply-To: <20171210063819.14892-6-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] i8259: move
 TYPE_INTERRUPT_STATS_PROVIDER upper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 12/10/2017 03:38 AM, Peter Xu wrote:
> Now both classes (i8259, i8259-kvm) support this.  Move this upper to
> the common class code.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/i386/kvm/i8259.c    | 7 -------
>  hw/intc/i8259.c        | 7 -------
>  hw/intc/i8259_common.c | 7 +++++++
>  3 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
> index 57abe091b0..b91e98074e 100644
> --- a/hw/i386/kvm/i8259.c
> +++ b/hw/i386/kvm/i8259.c
> @@ -140,15 +140,12 @@ static void kvm_i8259_class_init(ObjectClass *klass, void *data)
>      KVMPICClass *kpc = KVM_PIC_CLASS(klass);
>      PICCommonClass *k = PIC_COMMON_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
>  
>      dc->reset     = kvm_pic_reset;
>      kpc->parent_realize = dc->realize;
>      dc->realize   = kvm_pic_realize;
>      k->pre_save   = kvm_pic_get;
>      k->post_load  = kvm_pic_put;
> -    ic->get_statistics = pic_get_statistics;
> -    ic->print_info = pic_print_info;
>  }
>  
>  static const TypeInfo kvm_i8259_info = {
> @@ -157,10 +154,6 @@ static const TypeInfo kvm_i8259_info = {
>      .instance_size = sizeof(PICCommonState),
>      .class_init = kvm_i8259_class_init,
>      .class_size = sizeof(KVMPICClass),
> -    .interfaces = (InterfaceInfo[]) {
> -        { TYPE_INTERRUPT_STATS_PROVIDER },
> -        { }
> -    },
>  };
>  
>  static void kvm_pic_register_types(void)
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index d9b9666aff..1602255a87 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -442,13 +442,10 @@ static void i8259_class_init(ObjectClass *klass, void *data)
>  {
>      PICClass *k = PIC_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
>  
>      k->parent_realize = dc->realize;
>      dc->realize = pic_realize;
>      dc->reset = pic_reset;
> -    ic->get_statistics = pic_get_statistics;
> -    ic->print_info = pic_print_info;
>  }
>  
>  static const TypeInfo i8259_info = {
> @@ -457,10 +454,6 @@ static const TypeInfo i8259_info = {
>      .parent     = TYPE_PIC_COMMON,
>      .class_init = i8259_class_init,
>      .class_size = sizeof(PICClass),
> -    .interfaces = (InterfaceInfo[]) {
> -        { TYPE_INTERRUPT_STATS_PROVIDER },
> -        { }
> -    },
>  };
>  
>  static void pic_register_types(void)
> diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
> index 7efd2e8012..c75c880157 100644
> --- a/hw/intc/i8259_common.c
> +++ b/hw/intc/i8259_common.c
> @@ -178,6 +178,7 @@ static Property pic_properties_common[] = {
>  static void pic_common_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
>  
>      dc->vmsd = &vmstate_pic_common;
>      dc->props = pic_properties_common;
> @@ -189,6 +190,8 @@ static void pic_common_class_init(ObjectClass *klass, void *data)
>       * code.
>       */
>      dc->user_creatable = false;
> +    ic->get_statistics = pic_get_statistics;
> +    ic->print_info = pic_print_info;
>  }
>  
>  static const TypeInfo pic_common_type = {
> @@ -198,6 +201,10 @@ static const TypeInfo pic_common_type = {
>      .class_size = sizeof(PICCommonClass),
>      .class_init = pic_common_class_init,
>      .abstract = true,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_INTERRUPT_STATS_PROVIDER },
> +        { }
> +    },
>  };
>  
>  static void pic_common_register_types(void)
> 
