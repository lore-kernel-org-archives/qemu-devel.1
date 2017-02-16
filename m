Received: from eggs.gnu.org ([2001:4830:134:3::10]:42597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceKsL-00076w-Nk
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceKsK-0006zS-Nv
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:09:29 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceKsK-0006zK-FK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:09:28 -0500
Received: by mail-wm0-x235.google.com with SMTP id r141so13523657wmg.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:09:28 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 12:09:06 +0000
Message-ID: <CAFEAcA9GHWQCUrgYsT_Bnsy8_ZYP073_DWBcoRvX2Hg+F=_h5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] problems with qapi2texi.py (use of @quotation)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <mlureau@redhat.com>

When we build qemu-qmp-ref.txt this causes texinfo to complain several
times:
"Negative repeat count does nothing at
/usr/share/texinfo/Texinfo/Convert/Line.pm line 124."

I dug into what's happening here a bit, and I think the problem is
that we're generating bogus texinfo.

In particular I think they're the result of the three places where
we try to have an enumerated list inside a Notes section, which
generate texi like this:

@quotation Notes
@enumerate
@item
The 'query-migrate' command should be used to check migration's progress
and final result (this information is provided by the 'status' member)

@item
All boolean arguments default to false

@item
The user Monitor's "detach" argument is invalid in QMP and should not
be used
@end enumerate

@end quotation

This is definitely not what @quotation is supposed to be used for,
and I think the nested indentation (since @enumerate also indents)
is confusing things.

It also doesn't display correctly, because the "Notes" text disappears
entirely in the HTML version because it thinks there's no actual
quotation text.

Similarly, all the Examples lose the "Examples" heading text because
they're an @example inside a @quotation and the @quotation handling
thinks there's no actual quotation text.

The text file output formatting is also not good, for instance:

          Notes: 1. The 'query-migrate' command should be used to check
               migration's progress and final result (this information
               is provided by the 'status' member)

            2. All boolean arguments default to false

            3. The user Monitor's "detach" argument is invalid in QMP
               and should not be used

          Example: -> { "execute": "migrate", "arguments": { "uri":
"tcp:0:4446" } }
               <- { "return": {} }

where the lack of a line break after "Example:" and "Notes:"
means things don't line up right.

I think the best fix for all these problems is to stop misusing
@quotation for doing something other than printing quotations,
and use something that just formats the "Notes", "Examples",
etc lines the way we want. I don't know enough texinfo to
suggest what that should be, though.

thanks
-- PMM
