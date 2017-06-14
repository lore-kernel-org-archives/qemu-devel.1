Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL9nX-0005Dj-8C
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL9nS-00069T-Rk
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:01:31 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL9nS-00068z-G4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:01:26 -0400
Received: by mail-wr0-x235.google.com with SMTP id r103so2126968wrb.0
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:01:26 -0700 (PDT)
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-3-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1497369290-20401-3-git-send-email-peter.maydell@linaro.org>
Date: Wed, 14 Jun 2017 16:01:58 +0100
Message-ID: <8760fyobo9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] scripts/run-coverity-scan: Script to
 run Coverity Scan build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add a new script to automate the process of running the Coverity
> Scan build tools and uploading the resulting tarball to the
> website. This is primarily intended to be driven from Travis,
> but it can be run locally (if you are a maintainer of the
> QEMU project on the Coverity Scan website and have the secret
> upload token).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  scripts/run-coverity-scan | 170 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100755 scripts/run-coverity-scan
>
> diff --git a/scripts/run-coverity-scan b/scripts/run-coverity-scan
> new file mode 100755
> index 0000000..e6d5fc5
> --- /dev/null
> +++ b/scripts/run-coverity-scan
> @@ -0,0 +1,170 @@
> +#!/bin/sh -e
> +
> +# Upload a created tarball to Coverity Scan, as per
> +# https://scan.coverity.com/projects/qemu/builds/new
> +
> +# This work is licensed under the terms of the GNU GPL version 2,
> +# or (at your option) any later version.
> +# See the COPYING file in the top-level directory.
> +#
> +# Copyright (c) 2017 Linaro Limited
> +# Written by Peter Maydell
> +
> +# Note that this script will automatically download and
> +# run the (closed-source) coverity build tools, so don't
> +# use it if you don't trust them!
> +
> +# This script assumes that you're running it from a QEMU source
> +# tree, and that tree is a fresh clean one, because we do an in-tree
> +# build. (This is necessary so that the filenames that the Coverity
> +# Scan server sees are relative paths that match up with the component
> +# regular expressions it uses; an out-of-tree build won't work for this.)
> +# The host machine should have as many of QEMU's dependencies
> +# installed as possible, for maximum coverity coverage.
> +
> +# You need to pass the following environment variables to the script:
> +#  COVERITY_TOKEN -- this is the secret 8 digit hex string which lets
> +#                    you upload to Coverity Scan. If you're a maintainer
> +#                    in Coverity then the web UI will tell you this.
> +#  COVERITY_EMAIL -- the email address to use for uploads
> +
> +# and optionally
> +#  COVERITY_DRYRUN -- set to not actually do the upload
> +#  COVERITY_BUILD_CMD -- make command (defaults to 'make -j8')
> +#  COVERITY_TOOL_BASE -- set to directory to put coverity tools
> +#                        (defaults to /tmp/coverity-tools)
> +
> +# The primary purpose of this script is to be run as part of
> +# a Travis build, but it is possible to run it manually locally.
> +
> +if [ -z "$COVERITY_TOKEN" ]; then
> +    echo "COVERITY_TOKEN environment variable not set"
> +    exit 1
> +fi
> +
> +if [ -z "$COVERITY_EMAIL" ]; then
> +    echo "COVERITY_EMAIL environment variable not set"
> +    exit 1
> +fi
> +
> +if [ -z "$COVERITY_BUILD_CMD" ]; then
> +    echo "COVERITY_BUILD_CMD: using default 'make -j8'"
> +    COVERITY_BUILD_CMD="make -j8"
> +fi
> +
> +if [ -z "$COVERITY_TOOL_BASE" ]; then
> +    echo "COVERITY_TOOL_BASE: using default /tmp/coverity-tools"
> +    COVERITY_TOOL_BASE=/tmp/coverity-tools
> +fi
> +
> +PROJTOKEN="$COVERITY_TOKEN"
> +PROJNAME=QEMU
> +TARBALL=cov-int.tar.xz
> +SRCDIR="$(pwd)"
> +
> +echo "Checking this is a QEMU source tree..."
> +if ! [ -e VERSION ]; then
> +    echo "Not in a QEMU source tree?"
> +    exit 1
> +fi
> +
> +echo "Checking upload permissions..."
> +
> +if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$PROJTOKEN&project=$PROJNAME" -q -O -)"; then
> +    echo "Coverity Scan API access denied: bad token?"
> +    exit 1
> +fi
> +
> +# Really up_perm is a JSON response with either
> +# {upload_permitted:true} or {next_upload_permitted_at:<date>}
> +# We do some hacky string parsing instead of properly parsing it.
> +case "$up_perm" in
> +    *upload_permitted*true*)
> +        echo "Coverity Scan: upload permitted"
> +        ;;
> +    *next_upload_permitted_at*)
> +        if [ -z "$COVERITY_DRYRUN" ]; then
> +            echo "Coverity Scan: upload quota reached; stopping here"
> +            # Exit success as this isn't a build error.
> +            exit 0
> +        else
> +            echo "Coverity Scan: upload quota reached, continuing dry run"
> +        fi
> +        ;;
> +    *)
> +        echo "Coverity Scan upload check: unexpected result $up_perm"
> +        exit 1
> +        ;;
> +esac
> +
> +mkdir -p "$COVERITY_TOOL_BASE"
> +cd "$COVERITY_TOOL_BASE"
> +
> +echo "Checking for new version of coverity build tools..."
> +wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME&md5=1" -O coverity_tool.md5.new
> +
> +if ! cmp -s coverity_tool.md5 coverity_tool.md5.new; then
> +    # out of date md5 or no md5: download new build tool
> +    # blow away the old build tool
> +    echo "Downloading coverity build tools..."
> +    rm -rf coverity_tool coverity_tool.tgz
> +    wget https://scan.coverity.com/download/linux64 --post-data "token=$PROJTOKEN&project=$PROJNAME" -O coverity_tool.tgz
> +    if ! (cat coverity_tool.md5.new; echo "  coverity_tool.tgz") | md5sum -c --status; then
> +        echo "Downloaded tarball didn't match md5sum!"
> +        exit 1
> +    fi
> +    # extract the new one, keeping it corralled in a 'coverity_tool' directory
> +    echo "Unpacking coverity build tools..."
> +    mkdir -p coverity_tool
> +    cd coverity_tool
> +    tar xf ../coverity_tool.tgz
> +    cd ..
> +    mv coverity_tool.md5.new coverity_tool.md5
> +fi
> +
> +rm -f coverity_tool.md5.new
> +
> +TOOLBIN="$(echo $(pwd)/coverity_tool/cov-analysis-*/bin)"
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
> +./configure --audio-drv-list=oss,alsa,sdl,pa --disable-werror
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
> +VERSION="$(git describe --always HEAD)"
> +DESCRIPTION="$(git rev-parse HEAD)"
> +
> +if ! [ -z "$COVERITY_DRYRUN" ]; then
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


--
Alex Bennée
