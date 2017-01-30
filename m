Received: from eggs.gnu.org ([2001:4830:134:3::10]:45310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cYCen-0007Eu-O3
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:10:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cYCej-00072F-Rk
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:10:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cYCej-00071Z-Lo
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:10:05 -0500
References: <20170130131517.8092-1-sw@weilnetz.de>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c8f2b3c6-34b9-cfe1-0363-8afa5ab1ec0f@redhat.com>
Date: Mon, 30 Jan 2017 15:10:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170130131517.8092-1-sw@weilnetz.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Fix broken user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>

Am 30.01.2017 um 14:15 schrieb Stefan Weil:
> Returning NULL from get_max_cpu_model results in a SIGSEGV runtime error.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> v2: Re-sent as v1 was damaged by my mailer.
> 
> This is also broken in Debian.
> 
> In addition, there is no default CPU ("any"), so binfmt and related
> actions currently don't work. I hacked my local installation by
> duplicating the "qemu" cpu definition for "any", but maybe there is
> a better solution.

we have the "qemu" model for that (or simply drop the -cpu parameter
completely). Eduardo currently proposed "max" as an alternative for x86.
There is also no "any" model on x86.

> 
> Regards
> Stefan
> 
>  target/s390x/cpu_models.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 2a894ee..6e34763 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -660,7 +660,6 @@ static void check_compatibility(const S390CPUModel *max_model,
>  
>  static S390CPUModel *get_max_cpu_model(Error **errp)
>  {
> -#ifndef CONFIG_USER_ONLY
>      static S390CPUModel max_model;
>      static bool cached;
>  
> @@ -680,7 +679,6 @@ static S390CPUModel *get_max_cpu_model(Error **errp)
>          cached = true;
>          return &max_model;
>      }
> -#endif
>      return NULL;
>  }
>  
> 

Okay, the main problem is that get_max_cpu_model() doesn't return an
error in this case, therefor s390_realize_cpu_model() doesn't fail
correctly.

But it seems like cpu models also make sense for user mode (as you
recognized, we tried to not touch it but failed). However, for now, just
as for ordinary tcg, only "qemu"/z900 is supported, until proper support
for tcg is implemented.

Then, also the CONFIG_USER_ONLY in apply_cpu_model() has to go.

So this makes sense to me and should fix the current problem.

-- 

David
