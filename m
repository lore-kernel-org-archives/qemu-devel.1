Received: from eggs.gnu.org ([2001:4830:134:3::10]:44827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYtsP-0002Vy-Bl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYtsM-0004v2-8a
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:55:53 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYtsM-0004tC-1L
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:55:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so2175035wma.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 06:55:49 -0700 (PDT)
References: <20180418171151.5263-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a22e422e-b7bb-75eb-bc64-332a3012e7d5@redhat.com>
Date: Fri, 29 Jun 2018 15:55:46 +0200
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

On 18/04/2018 19:11, Daniel P. Berrangé wrote:
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
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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

Queued, thanks.

Paolo
