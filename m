Received: from eggs.gnu.org ([2001:4830:134:3::10]:59508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMrU3-0000lh-Qt
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dMrU0-0000Yc-Qp
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:52:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dMrU0-0000Xx-JT
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:52:24 -0400
References: <20170616051526.6814-1-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e989e9c7-ed59-fc97-7fa4-4b309762b176@redhat.com>
Date: Mon, 19 Jun 2017 09:52:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170616051526.6814-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Enforce instruction
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

On 16.06.2017 07:15, Richard Henderson wrote:
> Introduce a synthetic feature (type MISC) to handle disabling of
> the enforcing of features at translation time.
> 
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/cpu_features.c     | 4 +++-
>  target/s390x/cpu_features_def.h | 1 +
>  target/s390x/cpu_models.c       | 5 +++++
>  target/s390x/translate.c        | 9 +++++++++
>  4 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index 42fd9d7..8d542c0 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -24,7 +24,7 @@
>      }
>  
>  /* indexed by feature number for easy lookup */
> -static const S390FeatDef s390_features[] = {
> +static const S390FeatDef s390_features[S390_FEAT_MAX] = {
>      FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n3"),
>      FEAT_INIT("zarch", S390_FEAT_TYPE_STFL, 1, "z/Architecture architectural mode"),
>      FEAT_INIT("dateh", S390_FEAT_TYPE_STFL, 3, "DAT-enhancement facility"),
> @@ -251,6 +251,8 @@ static const S390FeatDef s390_features[] = {
>      FEAT_INIT("pcc-xts-eaes-256", S390_FEAT_TYPE_PCC, 60, "PCC Compute-XTS-Parameter-Using-Encrypted-AES-256"),
>  
>      FEAT_INIT("ppno-sha-512-drng", S390_FEAT_TYPE_PPNO, 3, "PPNO SHA-512-DRNG"),
> +
> +    FEAT_INIT("tcg-all-insns", S390_FEAT_TYPE_MISC, 0, "Enable all insns supported by TCG"),

Very mixed feelings about fake features. Will return
strange/wrong/misleading information on baselining/comparing..... I
don't like this.

Basically also because this is a temporary hack and will - in theory -
be dropped at one point. nack from my side.


Can't we just handle the qemu model special as proposed?


-- 

Thanks,

David
