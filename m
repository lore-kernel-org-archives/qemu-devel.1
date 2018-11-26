Received: from eggs.gnu.org ([2001:4830:134:3::10]:51684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRKSQ-00070C-VI
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRKSK-0001EX-VA
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:14:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRKSI-0001Dc-VE
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:13:56 -0500
References: <20181126152836.25379-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a0ce0395-576b-8175-67ad-7116d021e39e@redhat.com>
Date: Mon, 26 Nov 2018 18:13:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181126152836.25379-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

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

Queued, thanks.

Paolo
