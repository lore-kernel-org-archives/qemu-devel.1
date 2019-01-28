Received: from eggs.gnu.org ([209.51.188.92]:51412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go8XP-0008Io-9t
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1go8JU-0003gJ-93
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:55:04 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:50494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1go8JU-0003fu-3b
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:55:04 -0500
Received: by mail-wm1-f50.google.com with SMTP id n190so14334318wmd.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 06:55:04 -0800 (PST)
References: <1548678699-15717-1-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ae5efb07-6079-e102-4c21-65bdd5c9d9a2@redhat.com>
Date: Mon, 28 Jan 2019 15:55:00 +0100
MIME-Version: 1.0
In-Reply-To: <1548678699-15717-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x: remove direct reference to
 mem_path global form s390x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: david@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On 1/28/19 1:31 PM, Igor Mammedov wrote:
> I plan to deprecate -mem-path option and replace it with memory-backend,
> for that it's necessary to get rid of mem_path global variable.
> Do it for s390x case, replacing it with alternative way to enable
> 1Mb hugepages capability.
> 
> Todo that replace qemu_mempath_getpagesize() with qemu_getrampagesize()

I guess this should be: "To do that, replace ..."

> which also checks for -mem-path provided RAM.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   * s/qemu_mempath_getpagesize/qemu_getrampagesiz/ and drop the rest of changes
>           David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2ebf26a..90766fa 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -287,7 +287,7 @@ void kvm_s390_crypto_reset(void)
>  
>  static int kvm_s390_configure_mempath_backing(KVMState *s)
>  {
> -    size_t path_psize = qemu_mempath_getpagesize(mem_path);
> +    size_t path_psize = qemu_getrampagesize();
>  
>      if (path_psize == 4 * KiB) {
>          return 0;
> @@ -319,7 +319,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> -    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
> +    if (kvm_s390_configure_mempath_backing(s)) {
>          return -EINVAL;
>      }
>  
> 
