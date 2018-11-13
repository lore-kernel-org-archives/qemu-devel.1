Received: from eggs.gnu.org ([2001:4830:134:3::10]:45970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMeGO-0000PN-B9
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:22:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMeGL-0003GA-Rm
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:22:15 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMeGK-0003EY-8y
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:22:12 -0500
Received: by mail-oi1-x241.google.com with SMTP id r127-v6so11390689oie.3
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 11:22:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b332dd35-0cec-7687-7b68-118e560964a1@redhat.com>
References: <20181113184641.4492-1-peter.maydell@linaro.org>
	<20181113184641.4492-2-peter.maydell@linaro.org>
	<b332dd35-0cec-7687-7b68-118e560964a1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 19:21:44 +0000
Message-ID: <CAFEAcA-Fw2niH-XevrqTacouNcM=+xbT3qAqyyuQi+8oK_Xkig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 13 November 2018 at 19:06, Eric Blake <eblake@redhat.com> wrote:
> On 11/13/18 12:46 PM, Peter Maydell wrote:
>>
>> Add a new script to automate the process of running the Coverity
>> Scan build tools and uploading the resulting tarball to the
>> website.
>>
>> This is intended eventually to be driven from Travis,
>> but it can be run locally, if you are a maintainer of the
>> QEMU project on the Coverity Scan website and have the secret
>> upload token.
>>
>> The script must be run directly on a Fedora 28 system.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---

Thanks for the code review -- my shell scripting has some
bad habits in it.

>
>> +++ b/scripts/coverity-scan/run-coverity-scan
>> @@ -0,0 +1,292 @@
>> +#!/bin/sh -e
>
>
> set -e...
>
>> +check_upload_permissions() {
>
>
> ...and shell functions do NOT intuitively do what you would think. It's
> almost always better to use explicit error checking than to rely on set -e
> as a crutch, because then you don't get surprises.

I think we had this conversation with last year's version
of this script too :-)  As you say, the use of functions
makes it maybe better to use explicit error checking -- but
is there a standard syntax for that that doesn't make
basic
 foo
 bar
 baz
"do these things in order" code look weird and require special care?
At least with set -e you do get error checking, whereas scripts without
it tend to just plough on regardless (look at configure, which doesn't
use set -e but doesn't have explicit checking either).

>> +    # Check whether we can do an upload to the server; will exit the
>> script
>> +    # with status 1 if the check failed (usually a bad token);
>> +    # will exit the script with status 0 if the check indicated that we
>> +    # can't upload yet (ie we are at quota)
>> +    # Assumes that PROJTOKEN, PROJNAME and DRYRUN have been initialized.
>> +
>> +    echo "Checking upload permissions..."
>> +
>> +    if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted
>> --post-data "token=$PROJTOKEN&project=$PROJNAME" -q -O -)"; then
>> +        echo "Coverity Scan API access denied: bad token?"
>> +        exit 1
>> +    fi
>> +
>> +    # Really up_perm is a JSON response with either
>> +    # {upload_permitted:true} or {next_upload_permitted_at:<date>}
>> +    # We do some hacky string parsing instead of properly parsing it.
>> +    case "$up_perm" in
>> +        *upload_permitted*true*)
>> +            echo "Coverity Scan: upload permitted"
>> +            ;;
>> +        *next_upload_permitted_at*)
>> +            if [ "$DRYRUN" = yes ]; then
>> +                echo "Coverity Scan: upload quota reached; stopping here"
>> +                # Exit success as this isn't a build error.
>> +                exit 0
>> +            else
>> +                echo "Coverity Scan: upload quota reached, continuing dry
>> run"
>> +            fi
>
>
> Did you get the logic backwards on this if?  Based on the error message, I
> was guessing the intended condition was [ "$DRYRUN" != yes ]

Yes, I did (I flipped the way I was doing checks from "unset
means no" to "check if it is yes", and didn't get it right;
I caught another instance of this later, but missed this one.)

>> +done
>> +
>> +if [ -z "$COVERITY_TOKEN" ]; then
>> +    echo "COVERITY_TOKEN environment variable not set"
>> +    exit 1
>> +fi
>> +
>> +if [ -z "$COVERITY_BUILD_CMD" ]; then
>> +    echo "COVERITY_BUILD_CMD: using default 'make -j8'"
>> +    COVERITY_BUILD_CMD="make -j8"
>
>
> Should this query 'nproc' instead of hard-coding -j8?

Probably. Legacy of this thing developing from a local hack
into something a bit more 'production'.

>> +fi
>> +
>> +if [ -z "$COVERITY_TOOL_BASE" ]; then
>> +    echo "COVERITY_TOOL_BASE: using default /tmp/coverity-tools"
>> +    COVERITY_TOOL_BASE=/tmp/coverity-tools
>> +fi
>> +
>> +if [ -z "$SRCDIR" ]; then
>> +    SRCDIR="$(pwd)"
>
>
> Why not save a process, and just use SRCDIR="$PWD"

I never remember that $PWD exists, because when I'm doing
things on a shell command line I always use 'pwd'. But
it would be better, yes.

>> +TOOLBIN="$(cd "$COVERITY_TOOL_BASE" && echo
>> $(pwd)/coverity_tool/cov-analysis-*/bin)"
>
>
> If $CDPATH is set and $COVERITY_TOOL_BASE does not contain /, this could
> result in garbage being prepended to TOOLBIN as output from the 'cd'. Also,
> $PWD is nicer than $(pwd); but are you sure the glob in cov-analysis-* won't
> select too many files?

The glob is not great, but it is necessary to make the script
robust over new versions of the tools, which put the version
number in the cov-analysis-whatever directory name. If
we do ever get more than one file then the "test -x" below
will fail, and we'll be able to investigate and fix up the script.

CDPATH sounds like a horrific misfeature designed for breaking
scripts, so I'm not very interested in trying to work around it.
We don't seem to worry about this in configure either.
(I suppose we could just unset it at the start of the script.)

thanks
-- PMM
