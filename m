Received: from eggs.gnu.org ([209.51.188.92]:36550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hCXQO-0000zc-Lw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 18:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hCXQN-00048q-NQ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 18:35:04 -0400
References: <1554378405-11640-1-git-send-email-706701795@qq.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f6d784b8-3702-e8bb-a79f-6887acbef354@redhat.com>
Date: Fri, 5 Apr 2019 18:34:56 -0400
MIME-Version: 1.0
In-Reply-To: <1554378405-11640-1-git-send-email-706701795@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] Fixed dump_buffer function
 parameter offset does not take effect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lichun <706701795@qq.com>, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

Hi! Thank you for this patch.

Some notes follow:

On 4/4/19 7:46 AM, lichun wrote:
> Signed-off-by: lichun <706701795@qq.com>

You should write a commit message explaining the problem being fixed by
this patch, even if it's very brief.

In the future, try wording subject lines in terms of what the patch
"does" instead of what it "did"; i.e.:

"Fix dump_buffer function so that the offset parameter takes effect"
is preferable to
"Fixed dump_buffer function parameter offset does not take effect"

> ---
>  qemu-io-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index 09750a2..8d93dc6 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -357,7 +357,7 @@ static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
>      int j;
>      const uint8_t *p;
>  
> -    for (i = 0, p = buffer; i < len; i += 16) {
> +    for (i = 0, p = buffer + offset; i < len; i += 16) {
>          const uint8_t *s = p;
>  
>          printf("%08" PRIx64 ":  ", offset + i);
> 

At a glance I am not sure that this patch is correct, it looks to me as
if callers are expecting the entire buffer to be dumped and the offset
is the offset of *this buffer* relative to some reference point (e.g.
the disk being read from.)

Can you point me to examples in which this is obviously wrong?
