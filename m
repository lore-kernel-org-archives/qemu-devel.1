Received: from eggs.gnu.org ([2001:4830:134:3::10]:60719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9DPi-0007Fq-Kc
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9DPe-0006T5-L3
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:32:06 -0400
Received: from mail-qk0-x22f.google.com ([2607:f8b0:400d:c09::22f]:37384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9DPe-0006R5-GE
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 13:32:02 -0400
Received: by mail-qk0-x22f.google.com with SMTP id d74so6129808qkg.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 10:32:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180418171151.5263-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0e730f45-665b-e646-decc-c9d234a1292f@amsat.org>
Date: Thu, 19 Apr 2018 14:31:58 -0300
MIME-Version: 1.0
In-Reply-To: <20180418171151.5263-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] configure: add sanity check to catch
 builds from "git archive"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org



On 04/18/2018 02:11 PM, Daniel P. Berrangé wrote:
> The "git archive" feature creates tarballs which are missing all
> submodule content. GitHub unhelpfully provides users with "Download"
> links that claim to give them valid source release tarballs. These
> GitHub archives will not be buildable as they are created by the
> "git archive" feature and so are missing content. The user gets
> unhelpful messages from make such as:
> 
>   fatal error: ui/input-keymap-atset1-to-qcode.c: No such file or directory
> 
> By adding a sanity check we can give users an informative message about
> what they've done wrong.

tested with https://github.com/philmd/qemu/archive/github_notag.tar.gz

    github_notag$ ./configure

    ERROR: missing file ./ui/keycodemapdb/README

    This is not a GIT checkout but module content appears to
    be missing. Do not use 'git archive' or GitHub download links
    to acquire QEMU source archives. Non-GIT builds are only
    supported with source archives linked from:

     https://www.qemu.org/download/

    Developers working with GIT can use scripts/archive-source.sh
    if they need to create valid source archives.

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  configure | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/configure b/configure
> index 0a19b033bc..089b00068c 100755
> --- a/configure
> +++ b/configure
> @@ -296,6 +296,24 @@ then
>  else
>      git_update=no
>      git_submodules=""
> +
> +    if ! test -f "$source_path/ui/keycodemapdb/README"
> +    then
> +        echo
> +        echo "ERROR: missing file $source_path/ui/keycodemapdb/README"
> +        echo
> +        echo "This is not a GIT checkout but module content appears to"
> +        echo "be missing. Do not use 'git archive' or GitHub download links"
> +        echo "to acquire QEMU source archives. Non-GIT builds are only"
> +        echo "supported with source archives linked from:"
> +        echo
> +        echo "  https://www.qemu.org/download/"
> +        echo
> +        echo "Developers working with GIT can use scripts/archive-source.sh"
> +        echo "if they need to create valid source archives."
> +        echo
> +        exit 1
> +    fi
>  fi
>  git="git"
>  
> 
