Received: from eggs.gnu.org ([2001:4830:134:3::10]:43182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEl4O-0001aR-JL
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEl4N-0008N2-Mz
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:56:44 -0500
Date: Tue, 14 Nov 2017 18:56:35 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <983758018.20192109.1510703795789.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171114232223.25207-1-mreitz@redhat.com>
References: <20171114232223.25207-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] util/stats64: Fix min/max
 comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org


----- Max Reitz <mreitz@redhat.com> ha scritto:
> stat64_min_slow() and stat64_max_slow() compare the wrong way.  This
> makes iotest 136 fail with clang and -m32.

Queued, thanks.

Cc: qemu-stable@nongnu.org

Paolo

> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  util/stats64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/util/stats64.c b/util/stats64.c
> index 9968fcceac..389c365a9e 100644
> --- a/util/stats64.c
> +++ b/util/stats64.c
> @@ -91,7 +91,7 @@ bool stat64_min_slow(Stat64 *s, uint64_t value)
>      low = atomic_read(&s->low);
>  
>      orig = ((uint64_t)high << 32) | low;
> -    if (orig < value) {
> +    if (value < orig) {
>          /* We have to set low before high, just like stat64_min reads
>           * high before low.  The value may become higher temporarily, but
>           * stat64_get does not notice (it takes the lock) and the only ill
> @@ -120,7 +120,7 @@ bool stat64_max_slow(Stat64 *s, uint64_t value)
>      low = atomic_read(&s->low);
>  
>      orig = ((uint64_t)high << 32) | low;
> -    if (orig > value) {
> +    if (value > orig) {
>          /* We have to set low before high, just like stat64_max reads
>           * high before low.  The value may become lower temporarily, but
>           * stat64_get does not notice (it takes the lock) and the only ill
> -- 
> 2.13.6
> 
