Received: from eggs.gnu.org ([2001:4830:134:3::10]:55801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1foAsV-0005M9-Vc
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1foAsR-0003F0-Fe
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:07:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1foAsR-0003EG-9i
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:07:03 -0400
References: <20180809160011.17225-1-peter.maydell@linaro.org>
	<19a9c0c6-03eb-d368-d8c8-fb62102556a4@redhat.com>
	<CAFEAcA_rRW7qbtiM4c-sBVmQhFMSuKnVqU6+oXsdXPwJ3GKv6A@mail.gmail.com>
	<9da04e7f-bd0c-9d50-fb7c-026b5aaa674c@redhat.com>
	<CAFEAcA_4M195VD57LyNVyWTLos140v2e7ymvuiY+rtJ4ZTCXwg@mail.gmail.com>
	<14a92c80-4aec-bd60-68fd-d6a68c8a63b6@redhat.com>
	<CAFEAcA-wiHi5KhYYSh5+invSZUW2xqk9J6SoZihQqqbmDfXusg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e54dba25-abc3-9c50-4159-1eddf3010132@redhat.com>
Date: Fri, 10 Aug 2018 19:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wiHi5KhYYSh5+invSZUW2xqk9J6SoZihQqqbmDfXusg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/checkpatch.pl: Enforce multiline
 comment syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>

On 10/08/2018 14:53, Peter Maydell wrote:
>> But otherwise, at least Eric, you, me (only now I admit), Thomas
>> expressed a preference for the other style; on the other side it's
>> Markus, Stefan, Conny and Alex, some of whom were okay with applying
>> maintainer discretion; John and rth wanted a third one but disagreed o=
n
>> their second choice.  I appreciate your writing the patch, but I'm not
>> sure that's consensus...
> What I strongly want is that checkpatch should (a) catch stuff
> I get wrong and (b) catch stuff that other people get wrong,
> so I don't have to nitpick over coding style myself (which I
> have done for multiline comment style in the past). So to me
> the current situation (checkpatch doesn't warn at all about
> out-of-style multiline comments) is no good.
>=20
> Nobody runs checkpatch on the whole existing codebase anyway,
> do they? So I think "3000 new warnings" is a red herring.

It's just a proxy for how many file would become inconsistent in the long
run, by respecting the new rule for now code and not changing the existin=
g
code.  So let's try doing it: :)

  git ls-tree -r HEAD | grep -v 'tests/tcg' | grep -v disas | \
    grep -v capstone | grep -v libxl | grep -v libdecnumber | \
    grep '\.[ch]$' | while read f g h i; do \
      scripts/checkpatch.pl -f $i;
  done | tee checkpatch.list

First of all, there were no hangs and only one file took a long time (ui/=
vgafont.h)
because it hits a quadratic loop; that was a nice start.

We have:

	Tested files: 3392
	Zero errors and zero warnings: 1938
	Zero errors, some warnings: 152
	Total errors + warnings: 82700 (only ~4000 warnings)

	Top reports:
	44425 ERROR: code indent should never use tabs
	19072 ERROR: space required / space prohibited
	4893 ERROR: braces {} are necessary for all arms
	3573 WARNING: line over 80 characters
	1198 ERROR: do not use C99 // comments
	1090 ERROR: line over 90 characters
	1053 ERROR: trailing statements should be on next line

So about 65% of the files pass before the patch, which is much better=20
than I actually thought.

A note about tabs: only 360 lines have a space-tab sequence, and
perhaps we could fix those.  18950 lines have tabs only at the beginning
of the line.  23405 lines have a single sequence of tabs in the middle
of the line but the indentation is otherwise absent or space-based.
But I digress.

With Peter's patch:

	Zero errors and zero warnings: 1269
	Zero errors, some warnings: 895

	New warnings:
	13214 WARNING: Block comments use a leading /* on a separate line
	4392 WARNING: Block comments use a trailing */ on a separate line
	2762 WARNING: Block comments use * on subsequent lines
	117 WARNING: Block comments should align the * on each line

With alternate rule (and dispensation for line 1):

	Zero errors and warnings: 1435
	Zero errors, some warnings: 831

	New warnings:
	4891 WARNING: Block comments use a leading /* on a separate line
	4392 WARNING: Block comments use a trailing */ on a separate line
	2762 WARNING: Block comments use * on subsequent lines
	117 WARNING: Block comments should align the * on each line

Given the number of warnings about trailing */, the 2-line format is much=
 more
prevalent than I thought.  We can assume that there are no comments with
separate "/*" and joined "*/", and then by comparing the different number
of warnings in the two cases you get the following estimates:

- 13713 multiline comments (13214+4891-4392)
- 1630 multiline comments in "2-line" format with asterisks (4392-2762)
- 2762 multiline comments in "2-line" format without asterisks
- 4430 multiline comments in "3-line" format
- 2024 doc comments (should be in "4-line" format, I spot checked a few d=
ozen;
  this was from a separate grep for "/\*\*$")
- 2867 multiline comments in "4-line" format (the rest)

So in conclusion: I'm not opposed to this patch, as long as someone conve=
rts
at least all 3-line comments to 4-line (including mine) and then the WARN=
 can
become an ERROR.  If someone wants to do that, the checkpatch output from=
 the
script at the top is probably a good start.  Otherwise the chosen format
should be the most common, considering that most maintainers have been us=
ing
it for 5 years or more.

If we want to accept both it's certainly fine by me, and then it's enough=
 not to
warn at all on the leading line.  In that case only 289 files (baseline i=
s 152)
would have zero errors and some warnings.  I think it's the best compromi=
se.

I attach the incremental patch I used for the alternate rule.

Paolo

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 52ab18bfce..0f182670b8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1568,10 +1568,18 @@ sub process {
=20
 # Block comment styles
=20
-		# Block comments use /* on a line of its own
-		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
-		    $rawline =3D~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-bla=
nk
-			WARN("Block comments use a leading /* on a separate line\n" . $herecu=
rr);
+		# Doc comments use /** on a line of its own
+		if ($rawline =3D~ m@/\*\*@ && $rawline !~ m@^\+[ \t]*/\*\*$@) { # /* o=
r /** non-blank
+			ERROR("Documentation comments use a leading /** on a separate line\n"=
 . $herecurr);
+		}
+		if ($rawline =3D~ m@\*\*/@ && $rawline !~ m@^\+[ \t]*\*\*\/@) { # /* o=
r /** non-blank
+			ERROR("Documentation comments use a trailing */ on a separate line\n"=
 . $herecurr);
+		}
+
+		# Block comments use /* on the first line, except for the license head=
er
+		if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&	#inline /*...*/
+		    $rawline =3D~ m@^\+.*/\*[ \t]*$@ && $realline > 1) { # /* or /** n=
on-blank
+			WARN("Block comment with leading /* on a separate line\n" . $herecurr=
);
 		}
=20
 # Block comments use * on subsequent lines
