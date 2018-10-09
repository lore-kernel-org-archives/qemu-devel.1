Received: from eggs.gnu.org ([2001:4830:134:3::10]:56890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xbl-00074E-Bf
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:23:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g9xbg-0007de-DS
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:23:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1g9xbg-0007d2-4K
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:23:48 -0400
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
	<1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <73457983-c541-81e1-044a-853df4abeb8e@redhat.com>
Date: Tue, 9 Oct 2018 15:23:46 -0400
MIME-Version: 1.0
In-Reply-To: <1535739372-24454-5-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] qemu-img: potential Null pointer
 deref in img_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org



On 08/31/2018 02:16 PM, Liam Merwick wrote:
> The function block_job_get() may return NULL so before dereferencing
> the 'job' pointer in img_commit() it should be checked.
> 
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  qemu-img.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index b12f4cd19b0a..51fe09bd08ed 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1029,6 +1029,9 @@ static int img_commit(int argc, char **argv)
>      }
>  
>      job = block_job_get("commit");
> +    if (job == NULL) {
> +        goto unref_backing;
> +    }
>      run_block_job(job, &local_err);
>      if (local_err) {
>          goto unref_backing;
> 
