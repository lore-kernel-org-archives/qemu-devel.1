Received: from eggs.gnu.org ([2001:4830:134:3::10]:40130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXjpy-0008V8-AY
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXjpu-0001Ut-Ry
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:32:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gXjpu-0001NM-It
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:32:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so4990841wmh.4
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 01:32:46 -0800 (PST)
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
	<cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
	<CAFEAcA9CpR=JGt74=xaUddYhf5SCOoeHH_v+O1L+rrTygZ7quQ@mail.gmail.com>
	<860b98f8-02d0-4c96-ccf2-d582ca295b95@redhat.com>
	<871s6kfwoo.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4f68f44-a5c1-ced4-30d2-99d0083a1214@redhat.com>
Date: Fri, 14 Dec 2018 10:32:43 +0100
MIME-Version: 1.0
In-Reply-To: <871s6kfwoo.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 14/12/18 07:29, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 13/12/18 19:21, Peter Maydell wrote:
>>> On Thu, 13 Dec 2018 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> On 13/12/18 19:01, Peter Maydell wrote:
>>>>> I sent a patch to do this a little while back:
>>>>>  https://patchwork.kernel.org/patch/10561557/
>>>>>
>>>>> It didn't get applied because Paolo disagreed with having
>>>>> our tools enforcing what our style guide says.
>>>>
>>>> I didn't disagree with that---I disagreed with having a single style in
>>>> the style guide, because unlike most other blatant violations of the
>>>> coding style (eg. braces), this one is pervasive in maintained code and
>>>> I don't want code that I maintain to mix two comment styles.
>>>>
>>>> So I proposed two alternatives:
>>>>
>>>> - someone fixes all the comment blocks which are "starred" but don't
>>>> have a lone "/*" at the beginning, and then we can commit that patch;
>>>>
>>>> - we allow "/* foo" on the first line, except for doc comments and for
>>>> the first line of the file (author/license block), and fix the style
>>>> guide accordingly.
>>>
>>> We came to a consensus on the comment style when we discussed
>>> the patch which updated CODING_STYLE. I'm not personally
>>> a fan of the result (I used to use "/* foo"), but what we have in the
>>> doc is what we achieved consensus for. I'm not going to reopen
>>> the "what should block comments look like" style debate.
>>
>> Sure, I don't want to do that either.  I accept the result of the
>> discussion; I don't accept introducing a new warning that will cause
>> over 700 files to become inconsistent sooner or later.
> 
> By design, checkpatch.pl only checks *patches*.  Existing code doesn't
> trigger warnings until it gets touched.  And then it should arguably be
> made to conform to CODING_STYLE.  So, what's the problem again?  :)

Once you add multiline comments to a file that has 3-line comments, they
have to be 4-line in order to appease checkpatch, and this create
inconsistencies.

In other words, it's not about checkpatch complaining on existing code.
 However, by running checkpatch on existing maintained code, you get a
measure of which files will grow an inconsistent style unless cleaned up
wholesale.

Anyway, in order to conclude the discussion and walk the walk, here is
the script.  It also converts GNU style to the anointed one.  I now
support applying Peter's patch, after the script is reviewed I'll send
it as a formal patch.

#! /bin/sh
#
# Fix multiline comments to match CODING_STYLE
#
# Copyright (C) 2018 Red Hat, Inc.
#
# Author: Paolo Bonzini
#
# Usage: scripts/fix-multiline-comments.sh [-i] FILE...
#
# -i edits the file in place (requires gawk 4.1.0).
#
# Set the AWK environment variable to choose the awk interpreter to use
# (default 'awk')

if test "$1" = -i; then
  # gawk extension
  inplace="-i inplace"
  shift
fi
${AWK-awk} $inplace 'BEGIN {
    getline first
    indent = -1
    while ((getline second) > 0) {
        # apply a star to the indent on lines after the first
        if (indent != -1) {
            if (first == "") {
                first = sp " *"
            } else if (substr(first, 1, indent + 2) == sp "  ") {
                first = sp " *" substr(first, indent + 3)
            }
        }

        is_lead = (first ~ /^[ \t]*\/\*/)
        is_trail = (first ~ /\*\//)
        if (is_lead && !is_trail) {
            # grab the indent at the start of a comment, but not for
            # single-line comments
            match(first, /^[ \t]*\/\*/)
            indent = RLENGTH - 2
            sp = substr(first, 1, indent)
        }

        # the regular expression filters out lone /*, /**, or */
        if (indent != -1 && !(first ~ /^[ \t]*(\/\*+|\*\/)[ \t]*$/)) {
            if (is_trail) {
                # split the trailing */ on a separate line
                match(first, /[ \t]*\*\//)
                first = substr(first, 1, RSTART - 1) "\n" sp " */"
            }
            if (is_lead) {
                # split the leading /* on a separate line
                match(first, /^[ \t]*\/\*+[ \t]*/)
                first = sp "/*\n" sp " *" substr(first, RLENGTH)
            }
        }
        if (is_trail) {
            indent = -1
        }
        print first
        first = second
    }
    print first
}' "$@"

Paolo
