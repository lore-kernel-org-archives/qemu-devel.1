Received: from eggs.gnu.org ([209.51.188.92]:38019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtE2w-0002UD-VP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtE2w-0003Yq-0N
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:03:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtE2t-0003Sb-Ut
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:03:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so2377477wmj.0
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:02:50 -0800 (PST)
References: <1549897385-10091-1-git-send-email-liam.merwick@oracle.com>
	<1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <13b4d86c-0af3-12b9-fce5-92f1eb0fe95d@redhat.com>
Date: Mon, 11 Feb 2019 17:02:47 +0100
MIME-Version: 1.0
In-Reply-To: <1549897385-10091-3-git-send-email-liam.merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tpm_tis: fix format string
 specifier in tpm_tis_show_buffer()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, stefanb@linux.ibm.com, qemu-devel@nongnu.org

Hi Liam,

On 2/11/19 4:03 PM, Liam Merwick wrote:
> cppcheck reports:
> 
> [hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'
> 
> Fix this by using %u instead of %d
> 
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>  hw/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 860c2ace7d99..395500e8a61d 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -110,7 +110,7 @@ static void tpm_tis_show_buffer(const unsigned char *buffer,
>      uint32_t len, i;

If you want to clean this, use a size_t here instead of u32.

>  
>      len = MIN(tpm_cmd_get_size(buffer), buffer_size);
> -    printf("tpm_tis: %s length = %d\n", string, len);
> +    printf("tpm_tis: %s length = %u\n", string, len);

So here the format is '%zu'.
However in code cleanup we try go get ride of printf() calls and replace
them with trace points.

>      for (i = 0; i < len; i++) {
>          if (i && !(i % 16)) {
>              printf("\n");
> 
