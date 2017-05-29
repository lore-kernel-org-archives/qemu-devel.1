Received: from eggs.gnu.org ([2001:4830:134:3::10]:36186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFItQ-0006AD-7D
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFItN-0006P6-3K
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:31:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFItM-0006Ox-Sy
	for qemu-devel@nongnu.org; Mon, 29 May 2017 07:31:21 -0400
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-27-aurelien@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <66c633b7-bec7-93ff-3d1a-cd89b98a9e68@redhat.com>
Date: Mon, 29 May 2017 13:31:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-27-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/26] target/s390x: update maximum TCG
 model to z800
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

On 25.05.2017 23:05, Aurelien Jarno wrote:
> Now that the extended-translation facility 2 has been fully implemented,
> it's possible to emulated a most a z800 CPU with TCG.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/s390x/cpu_models.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 8d27363b07..9c4227d2dd 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -670,8 +670,8 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>      if (kvm_enabled()) {
>          kvm_s390_get_host_cpu_model(&max_model, errp);
>      } else {
> -        /* TCG emulates a z900 */
> -        max_model.def = &s390_cpu_defs[0];
> +        /* TCG emulates at most a z800 */
> +        max_model.def = &s390_cpu_defs[3];

These hard-coded offsets into s390_cpu_defs are kind of ugly ...
Maybe you could use

    max_model.def = s390_find_cpu_def(0x2066, 7, 3, NULL);

instead?

 Thomas
