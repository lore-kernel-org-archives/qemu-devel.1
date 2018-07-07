Received: from eggs.gnu.org ([2001:4830:134:3::10]:39112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbhGW-0008Jo-52
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 03:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fbhGT-0001bO-1M
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 03:04:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fbhGS-0001b3-OR
	for qemu-devel@nongnu.org; Sat, 07 Jul 2018 03:04:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id u7-v6so6029432wrn.12
	for <qemu-devel@nongnu.org>; Sat, 07 Jul 2018 00:04:16 -0700 (PDT)
References: <20180702151023.24532-1-shorne@gmail.com>
	<20180702151023.24532-23-shorne@gmail.com>
	<feef2195-8fd8-f9e1-da85-f3286a9e2b1d@amsat.org>
	<CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAAfxs77LqYG2gGT3Y0xs=SYMdQ9GoO0hymdwF-UGZcjXyrQUMg@mail.gmail.com>
Date: Sat, 07 Jul 2018 08:04:13 +0100
Message-ID: <87sh4v8r2q.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 22/25] linux-user: Implement signals for
 openrisc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>


Stafford Horne <shorne@gmail.com> writes:

> Hello,
>
> On Wed, Jul 4, 2018, 7:34 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
>> Hi Stafford,
>>
>> On 07/02/2018 12:10 PM, Stafford Horne wrote:
>> > From: Richard Henderson <richard.henderson@linaro.org>
<snip>
>
> Sorry, I brought these in from Richards tree and saw them but thought it
> was fine to keep the annotations.
>
> I'll remove them from patches in the future.
>
> Richard, how do you usually remove these before your pr?  I suppose you
> have some kind of script?
>

For reference these are my exact-steps:

  We need to ensure we have added our signoff and there is no ---
  ephemera left from commit history.

  ,----
  | errors=3D0
  | commits=3D0
  | while read rev; do
  |     author=3D$(git show -s --format=3D'%an <%ae>' $rev)
  |     body=3D$(git show -s --format=3D'%B' $rev)
  |
  |     # Check for Author signoff
  |     if ! grep -q "^Signed-off-by: $author" <<< "$body"; then
  |         errors=3D$((errors+1))
  |         echo "$rev missing signoff by $author"
  |     fi
  |
  |     # Check for my signoff
  |     if ! grep -q "^Signed-off-by: $signoff" <<< "$body"; then
  |         errors=3D$((errors+1))
  |         echo "$rev missing your signoff ($signoff)"
  |     fi
  |
  |     # Check for stray history
  |     if grep -q "^--" <<< "$body"; then
  |         errors=3D$((errors+1))
  |         echo "$rev may have history in it"
  |     fi
  |
  |     commits=3D$((commits+1))
  | done < <(git rev-list "origin/master..HEAD")
  |
  | echo "Found $errors errors over $commits commits"
  `----

  If we want to strip history we can run the following:

  ,----
  | current=3D$(git rev-parse --abbrev-ref HEAD)
  | if [ -d "${series}.pull" ]; then
  |   rm -rf ${series}.pull
  | fi
  | git format-patch origin/master..${current} -p -o ${series}.pull
  | prb=3D${current}-pr
  | echo ${prb}
  | git checkout -b ${prb} origin/master
  | git am ${series}.pull/*
  | rm -rf ${series}.pull
  `----

--
Alex Benn=C3=A9e
