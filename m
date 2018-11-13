Received: from eggs.gnu.org ([2001:4830:134:3::10]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMe1W-0005y1-Sn
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gMe1S-0004xi-TB
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:06:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gMe1S-0004ot-Hn
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:06:50 -0500
References: <20181113184641.4492-1-peter.maydell@linaro.org>
	<20181113184641.4492-2-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b332dd35-0cec-7687-7b68-118e560964a1@redhat.com>
Date: Tue, 13 Nov 2018 13:06:24 -0600
MIME-Version: 1.0
In-Reply-To: <20181113184641.4492-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] scripts/run-coverity-scan: Script to
 run Coverity Scan build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, patches@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 11/13/18 12:46 PM, Peter Maydell wrote:
> Add a new script to automate the process of running the Coverity
> Scan build tools and uploading the resulting tarball to the
> website.
> 
> This is intended eventually to be driven from Travis,
> but it can be run locally, if you are a maintainer of the
> QEMU project on the Coverity Scan website and have the secret
> upload token.
> 
> The script must be run directly on a Fedora 28 system.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -0,0 +1,292 @@
> +#!/bin/sh -e

set -e...

> +check_upload_permissions() {

...and shell functions do NOT intuitively do what you would think. It's 
almost always better to use explicit error checking than to rely on set 
-e as a crutch, because then you don't get surprises.

> +    # Check whether we can do an upload to the server; will exit the script
> +    # with status 1 if the check failed (usually a bad token);
> +    # will exit the script with status 0 if the check indicated that we
> +    # can't upload yet (ie we are at quota)
> +    # Assumes that PROJTOKEN, PROJNAME and DRYRUN have been initialized.
> +
> +    echo "Checking upload permissions..."
> +
> +    if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$PROJTOKEN&project=$PROJNAME" -q -O -)"; then
> +        echo "Coverity Scan API access denied: bad token?"
> +        exit 1
> +    fi
> +
> +    # Really up_perm is a JSON response with either
> +    # {upload_permitted:true} or {next_upload_permitted_at:<date>}
> +    # We do some hacky string parsing instead of properly parsing it.
> +    case "$up_perm" in
> +        *upload_permitted*true*)
> +            echo "Coverity Scan: upload permitted"
> +            ;;
> +        *next_upload_permitted_at*)
> +            if [ "$DRYRUN" = yes ]; then
> +                echo "Coverity Scan: upload quota reached; stopping here"
> +                # Exit success as this isn't a build error.
> +                exit 0
> +            else
> +                echo "Coverity Scan: upload quota reached, continuing dry run"
> +            fi

Did you get the logic backwards on this if?  Based on the error message, 
I was guessing the intended condition was [ "$DRYRUN" != yes ]

> +            ;;
> +        *)
> +            echo "Coverity Scan upload check: unexpected result $up_perm"
> +            exit 1
> +            ;;
> +    esac
> +}
> +
> +
> +update_coverity_tools () {
> +    # Check for whether we need to download the Coverity tools
> +    # (either because we don't have a copy, or because it's out of date)
> +    # Assumes that COVERITY_TOOL_BASE, PROJTOKEN and PROJNAME are set.
> +
> +    mkdir -p "$COVERITY_TOOL_BASE"
> +    cd "$COVERITY_TOOL_BASE"
> +
> +    echo "Checking for new version of coverity build tools..."
> +    wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
> +
> +    if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
> +        # out of date md5 or no md5: download new build tool
> +        # blow away the old build tool
> +        echo "Downloading coverity build tools..."
> +        rm -rf coverity_tool coverity_tool.tgz
> +        wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME" -O coverity_tool.tgz
> +        if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5sum -c --status; then
> +            echo "Downloaded tarball didn't match md5sum!"
> +            exit 1
> +        fi
> +        # extract the new one, keeping it corralled in a 'coverity_tool' directory
> +        echo "Unpacking coverity build tools..."
> +        mkdir -p coverity_tool
> +        cd coverity_tool
> +        tar xf ../coverity_tool.tgz

Assumes GNU tar, with its auto-decompression. But then again, you said 
the entire script assumes Fedora 28, so that's not necessarily bad.

> +        cd ..
> +        mv coverity_tool.md5.new coverity_tool.md5

Here's an example of where 'set -e' could bite - if tar or mv fails 
(perhaps due to ENOSPC), the decision of whether the shell function 
immediately stops or continues on to the next line (without handling the 
error) is dependent on the context that the caller used when calling 
update_coverity_tools (that is, 'update_coverity_tools' and 
'update_coverity_tools || fail' behave differently).

> +    fi
> +
> +    rm -f coverity_tool.md5.new
> +}
> +
> +
> +# Check user-provided environment variables and arguments
> +DRYRUN=no
> +UPDATE_ONLY=no
> +
> +while [ "$#" -ge 1 ]; do

> +done
> +
> +if [ -z "$COVERITY_TOKEN" ]; then
> +    echo "COVERITY_TOKEN environment variable not set"
> +    exit 1
> +fi
> +
> +if [ -z "$COVERITY_BUILD_CMD" ]; then
> +    echo "COVERITY_BUILD_CMD: using default 'make -j8'"
> +    COVERITY_BUILD_CMD="make -j8"

Should this query 'nproc' instead of hard-coding -j8?

> +fi
> +
> +if [ -z "$COVERITY_TOOL_BASE" ]; then
> +    echo "COVERITY_TOOL_BASE: using default /tmp/coverity-tools"
> +    COVERITY_TOOL_BASE=/tmp/coverity-tools
> +fi
> +
> +if [ -z "$SRCDIR" ]; then
> +    SRCDIR="$(pwd)"

Why not save a process, and just use SRCDIR="$PWD"

> +fi
> +
> +PROJTOKEN="$COVERITY_TOKEN"
> +PROJNAME=QEMU
> +TARBALL=cov-int.tar.xz
> +
> +
> +if [ "$UPDATE_ONLY" = yes ]; then
> +    # Just do the tools update; we don't need to check whether
> +    # we are in a source tree or have upload rights for this,
> +    # so do it before some of the command line and source tree checks.
> +    update_coverity_tools
> +    exit 0
> +fi
> +
> +cd "$SRCDIR"
> +
> +echo "Checking this is a QEMU source tree..."
> +if ! [ -e "$SRCDIR/VERSION" ]; then
> +    echo "Not in a QEMU source tree?"
> +    exit 1
> +fi
> +
> +# Fill in defaults used by the non-update-only process
> +if [ -z "$VERSION" ]; then
> +    VERSION="$(git describe --always HEAD)"
> +fi
> +
> +if [ -z "$DESCRIPTION" ]; then
> +    DESCRIPTION="$(git rev-parse HEAD)"
> +fi
> +
> +if [ -z "$COVERITY_EMAIL" ]; then
> +    COVERITY_EMAIL="$(git config user.email)"
> +fi
> +
> +check_upload_permissions
> +
> +update_coverity_tools
> +
> +TOOLBIN="$(cd "$COVERITY_TOOL_BASE" && echo $(pwd)/coverity_tool/cov-analysis-*/bin)"

If $CDPATH is set and $COVERITY_TOOL_BASE does not contain /, this could 
result in garbage being prepended to TOOLBIN as output from the 'cd'. 
Also, $PWD is nicer than $(pwd); but are you sure the glob in 
cov-analysis-* won't select too many files?

> +
> +if ! test -x "$TOOLBIN/cov-build"; then
> +    echo "Couldn't find cov-build in the coverity build-tool directory??"
> +    exit 1
> +fi
> +
> +export PATH="$TOOLBIN:$PATH"
> +
> +cd "$SRCDIR"
> +
> +echo "Doing make distclean..."
> +make distclean
> +
> +echo "Configuring..."
> +# We configure with a fixed set of enables here to ensure that we don't
> +# accidentally reduce the scope of the analysis by doing the build on
> +# the system that's missing a dependency that we need to build part of
> +# the codebase.
> +./configure --disable-modules --enable-sdl --with-sdlabi=2.0 --enable-gtk \
> +    --enable-opengl --enable-vte --enable-gnutls \
> +    --enable-nettle --enable-curses --enable-curl \
> +    --audio-drv-list=oss,alsa,sdl,pa --enable-virtfs \
> +    --enable-vnc --enable-vnc-sasl --enable-vnc-jpeg --enable-vnc-png \
> +    --enable-xen --enable-brlapi --enable-bluez \
> +    --disable-vde --enable-linux-aio --enable-attr \
> +    --enable-cap-ng --enable-trace-backends=log --enable-spice --enable-rbd \
> +    --enable-xfsctl --enable-libusb --enable-usb-redir \
> +    --enable-libiscsi --enable-libnfs --enable-seccomp \
> +    --enable-tpm --enable-libssh2 --enable-lzo --enable-snappy --enable-bzip2 \
> +    --enable-numa --enable-rdma --enable-smartcard --enable-virglrenderer \
> +    --enable-mpath --enable-libxml2 --enable-glusterfs
> +
> +echo "Making libqemustub.a..."
> +make libqemustub.a
> +
> +echo "Running cov-build..."
> +rm -rf cov-int
> +mkdir cov-int
> +cov-build --dir cov-int $COVERITY_BUILD_CMD
> +
> +echo "Creating results tarball..."
> +tar cvf - cov-int | xz > "$TARBALL"
> +
> +echo "Uploading results tarball..."
> +
> +if [ "$DRYRUN" = yes ]; then
> +    echo "Dry run only, not uploading $TARBALL"
> +    exit 0
> +fi
> +
> +curl --form token="$PROJTOKEN" --form email="$COVERITY_EMAIL" \
> +     --form file=@"$TARBALL" --form version="$VERSION" \
> +     --form description="$DESCRIPTION" \
> +     https://scan.coverity.com/builds?project="$PROJNAME"
> +
> +echo "Done."
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
