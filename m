Received: from eggs.gnu.org ([2001:4830:134:3::10]:57911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRJNg-0004td-14
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRJNc-00041G-7J
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:05:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRJNb-00040k-Th
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 11:05:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id s11so19134198wmh.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 08:04:59 -0800 (PST)
References: <20181126152836.25379-1-rkagan@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <73239a43-84b5-afee-a452-c0aff4088f3b@redhat.com>
Date: Mon, 26 Nov 2018 17:04:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181126152836.25379-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/hyperv: fix NULL dereference with
 pure-kvm SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 26/11/18 16:28, Roman Kagan wrote:
> When started in compat configuration of SynIC, e.g.
> 
> qemu-system-x86_64 -machine pc-i440fx-2.10,accel=kvm \
>  -cpu host,-vmx,hv-relaxed,hv_spinlocks=0x1fff,hv-vpindex,hv-synic
> 
> or explicitly
> 
> qemu-system-x86_64 -enable-kvm -cpu host,hv-synic,x-hv-synic-kvm-only=on
> 
> QEMU crashes in hyperv_synic_reset() trying to access the non-present
> qobject for SynIC.
> 
> Add the missing check for NULL.
> 
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reported-by: Igor Mammedov <imammedo@redhat.com>
> Fixes: 9b4cf107b09d18ac30f46fd1c4de8585ccba030c
> Fixes: 4a93722f9c279184e95b1e1ad775c01deec05065
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/hyperv/hyperv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index a28e7249d8..8758635227 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -136,7 +136,11 @@ void hyperv_synic_add(CPUState *cs)
>  
>  void hyperv_synic_reset(CPUState *cs)
>  {
> -    device_reset(DEVICE(get_synic(cs)));
> +    SynICState *synic = get_synic(cs);
> +
> +    if (synic) {
> +        device_reset(DEVICE(synic));
> +    }
>  }
>  
>  static const TypeInfo synic_type_info = {
> 
