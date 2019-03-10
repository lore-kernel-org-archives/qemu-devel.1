Received: from eggs.gnu.org ([209.51.188.92]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h327V-0008O2-Ci
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h3234-00057X-76
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:15:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h3233-00056x-Th
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 13:15:42 -0400
References: <20190306031221.GA53@03612eec87fc>
	<20190306045252.GG75@03612eec87fc>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <aa7609b9-be37-6a50-7471-20e814051dac@vivier.eu>
Date: Sun, 10 Mar 2019 18:15:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190306045252.GG75@03612eec87fc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 7/10] qemu-binfmt-conf.sh: add option
 --reset <ARCHS>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, eblake@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/03/2019 05:52, Unai Martinez-Corral wrote:
> This is a partial implementation.
> 
> Allows to remove a single or a list of already registered binfmt
> interpreters. If <ARCHS> is a list, it must be comma-separated.

I think ARCHS and CPUS are the same thing, so use the same word.

> Valid values are those in qemu_target_list. If <ARCHS> is 'ALL', all
> the existing 'qemu-*' interpreters are removed.
> 
> This is partial because 'debian' and 'systemd' configurations are not
> removed. If option 'reset' is provided before any of those, reset is
> executed first and the configuration proceeds. However, if 'reset' is
> provided after any of them, the script will exit with error 'option
> reset not implemented for this mode yet'.
> 
> Removal is done by printing '-1' as explained at:
> https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst
> 
> Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
> ---
>  scripts/qemu-binfmt-conf.sh | 36 +++++++++++++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 2751363089..824e3c4c34 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -197,8 +197,8 @@ qemu_get_family() {
> 
>  usage() {
>      cat <<EOF
> -Usage: qemu-binfmt-conf.sh [--path PATH][--debian][--systemd]
> -                           [--help][--credential][--exportdir PATH]
> +Usage: qemu-binfmt-conf.sh [--help][--path PATH][--debian][--systemd]
> +                           [--reset ARCHS][--credential][--exportdir PATH]
>                             [--persistent][--suffix SUFFIX][CPUS]

I don't like the idea of being able to set and reset different
interpretes with same command line call.

Make "--reset" exclusive without parameter to be able to use the common
cpu list at the end of the command line (this way, I think you would be
able to share more common code between setting an resetting).

You could have a look to Alex Bennée's patch:

  https://patchwork.ozlabs.org/patch/938796/

I think this is the good way to do this and it should merge easily with
your series.

Thanks,
Laurent
