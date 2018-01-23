Received: from eggs.gnu.org ([2001:4830:134:3::10]:34452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ee2Bl-0007zL-C4
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ee2Bi-00064L-7z
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:16:49 -0500
Received: from chuckie.co.uk ([82.165.15.123]:52781
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ee2Bi-00061U-0C
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:16:46 -0500
References: <20180123164718.12714-1-berrange@redhat.com>
	<20180123164718.12714-2-berrange@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <85d8f6cf-a944-6274-5811-8a178c295921@ilande.co.uk>
Date: Tue, 23 Jan 2018 17:16:29 +0000
MIME-Version: 1.0
In-Reply-To: <20180123164718.12714-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] Revert "build-sys: silence make by
 default or V=0"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23/01/18 16:47, Daniel P. Berrange wrote:

> This reverts commit 42a77f1ce4934b243df003f95bda88530631387a.
> 
> The primary intention of this change was to silence messages
> like
> 
>    make[1]: '/home/berrange/src/virt/qemu/capstone/libcapstone.a' is up to date.
> 
> which we get when calling make recursively with explicit
> targets.
> 
> The problem is that this change affected every make target,
> not merely the targets that triggered these "is up to date"
> messages. As a result any targets that were not invoking
> commands via "$(call quiet-command ...)" suddenly become
> silent. This is particularly bad for "make install" which
> now appears todo nothing.
> 
> Rather than go through every make rule and try to identify
> places where we now need to explicitly print a message to
> show work taking place, just revert the change.
> 
> To address the original problem of silencing "is up to date"
> messages, we simply add --quiet to the SUBDIR_MAKEVARS
> variable, so it only affects us on recursive make calls.

s/SUBDIR_MAKEVARS/SUBDIR_MAKEFLAGS/?

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   Makefile  | 2 +-
>   rules.mak | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f26ef1b1df..c263190b8d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -280,7 +280,7 @@ else
>   DOCS=
>   endif
>   
> -SUBDIR_MAKEFLAGS=BUILD_DIR=$(BUILD_DIR)
> +SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet) BUILD_DIR=$(BUILD_DIR)
>   SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
>   SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
>   
> diff --git a/rules.mak b/rules.mak
> index 5fb4951561..6e943335f3 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -131,8 +131,6 @@ modules:
>   # If called with only a single argument, will print nothing in quiet mode.
>   quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
>   
> -MAKEFLAGS += $(if $(V),,--no-print-directory --quiet)
> -
>   # cc-option
>   # Usage: CFLAGS+=$(call cc-option, -falign-functions=0, -malign-functions=0)

Thanks for spending the time debugging this, Dan.


ATB,

Mark.
