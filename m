Received: from eggs.gnu.org ([2001:4830:134:3::10]:36706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbPQ-00055N-LF
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEbPP-0002GK-Qv
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:37:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEbPP-0002FE-Lc
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:37:47 -0500
References: <20171114081630.27640.53933.stgit@pasha-VirtualBox>
	<20171114081829.27640.69432.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8c3617f-647a-f661-90d5-3db3b1e3760a@redhat.com>
Date: Tue, 14 Nov 2017 14:37:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171114081829.27640.69432.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/26] replay: check return values
 of fwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

On 14/11/2017 09:18, Pavel Dovgalyuk wrote:
> This patch adds error reporting when fwrite cannot completely
> save the buffer to the file.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> 
> ---
>  replay/replay-internal.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/replay/replay-internal.c b/replay/replay-internal.c
> index a1a7686..1888400 100644
> --- a/replay/replay-internal.c
> +++ b/replay/replay-internal.c
> @@ -62,7 +62,9 @@ void replay_put_array(const uint8_t *buf, size_t size)
>  {
>      if (replay_file) {
>          replay_put_dword(size);
> -        fwrite(buf, 1, size, replay_file);
> +        if (fwrite(buf, 1, size, replay_file) != size) {
> +            error_report("replay write error");
> +        }
>      }
>  }
>  
> 

Should the error be printed only once?  In addition, putc is not tested
in the same way.

Paolo
