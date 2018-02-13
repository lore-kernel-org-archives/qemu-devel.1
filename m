Received: from eggs.gnu.org ([2001:4830:134:3::10]:37776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elbwp-0000qd-RC
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elbwo-0004Dk-J8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:52:43 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:45092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elbwo-0004DN-D2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:52:42 -0500
Received: by mail-oi0-x229.google.com with SMTP id 23so1974996oip.12
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 06:52:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206164815.10084-1-alex.bennee@linaro.org>
References: <20180206164815.10084-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 14:52:21 +0000
Message-ID: <CAFEAcA8kq5PekaZVm5VpgLwa+VJYVX8pC5fE8RK8QiC9qA-aYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/22] re-factor softfloat and add fp16
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, bharata@linux.vnet.ibm.com, Andrew Dutcher <andrew@andrewdutcher.com>, QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2018 at 16:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Hi,
>
> The main change is applying the __attribute__((flatten)) to some of
> the public functions that show up in Emilio's dbt-benchmark. This
> seems to be a cleaner solution that squashing inlines higher up the
> chain and still leaves the chance for re-use for the less widely used
> functions. The results are an improvement over v3 by some margin:
>
>                          NBench score; higher is better
>
>     5 +-+-----------+-------------+------------+-------------+-----------=
+-+
>       |                     ****### %%%%  +++                            =
  |
>   4.5 +-+...................*..*..#.%..%..****##..%%%%+ system-2.5       =
+-+
>       |                     *  *  # %  %  *  * #  %  %      master       =
  |
>     4 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-v3       =
+-+
>   3.5 +-+...................*..*..#.%..%..*..*.#..%..%softfloat-%%%%.....=
+-+
>       |                     *  *  # %  %  *  * #  %  %  * *  #  %  %     =
  |
>     3 +-+...................*..*..#.%..%..*..*.#..%..%..*.*..#..%..%.....=
+-+
>       |                     *  *  #+%  %  *  * #$$$  %  * *  #  %  %     =
  |
>   2.5 +-+........####.......*..*..#$$..%..*..*.#..$..%..*.*..#..%..%.....=
+-+
>       |       ****  #  %%%  *  *  # $  %  *  * #  $  %  * *  #$$$  %     =
  |
>     2 +-+.....*..*..#..%.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>       |       *  *  #  % %  *  *  # $  %  *  * #  $  %  * *  #  $  %     =
  |
>   1.5 +-+.....*..*..#$$$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>     1 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %     =
  |
>   0.5 +-+.....*..*..#..$.%..*..*..#.$..%..*..*.#..$..%..*.*..#..$..%.....=
+-+
>       |       *  *  #  $ %  *  *  # $  %  *  * #  $  %  * *  #  $  %     =
  |
>     0 +-+-----****###$$$%%--****###$$%%%--****##$$$%%%--***###$$$%%%-----=
+-+
>                  FOURIER     NEURAL NETLU DECOMPOSITION    gmean
>
> Slightly easier to read PNG:
>
>     https://i.imgur.com/XEeL0bC.png
>
> I think it's pretty ready for a merge. Shall I submit a pull myself or
> does it make sense going via someone else? According to MAINTAINERS
> Peter and Aurelien are responsible for this code...
>
> Alex Benn=C3=A9e (22):
>   fpu/softfloat: implement float16_squash_input_denormal
>   include/fpu/softfloat: remove USE_SOFTFLOAT_STRUCT_TYPES
>   fpu/softfloat-types: new header to prevent excessive re-builds
>   target/*/cpu.h: remove softfloat.h
>   include/fpu/softfloat: implement float16_abs helper
>   include/fpu/softfloat: implement float16_chs helper
>   include/fpu/softfloat: implement float16_set_sign helper
>   include/fpu/softfloat: add some float16 constants
>   fpu/softfloat: improve comments on ARM NaN propagation
>   fpu/softfloat: move the extract functions to the top of the file
>   fpu/softfloat: define decompose structures
>   fpu/softfloat: re-factor add/sub
>   fpu/softfloat: re-factor mul
>   fpu/softfloat: re-factor div
>   fpu/softfloat: re-factor muladd
>   fpu/softfloat: re-factor round_to_int
>   fpu/softfloat: re-factor float to int/uint
>   fpu/softfloat: re-factor int/uint to float
>   fpu/softfloat: re-factor scalbn
>   fpu/softfloat: re-factor minmax
>   fpu/softfloat: re-factor compare
>   fpu/softfloat: re-factor sqrt

If you persuade git to use the --minimal, --patience or --histogram
git diff option when generating these patches you'll find that it
doesn't produce unreadable patches that provoke all the checkpatch
warnings. That in turn will let you find the genuine warning that
got lost in all the spurious ones:

Checking PATCH 16/22: fpu/softfloat: re-factor round_to_int...
WARNING: line over 80 characters
#127: FILE: fpu/softfloat.c:1261:
+                inc =3D ((a.frac & roundeven_mask) !=3D frac_lsbm1 ?
frac_lsbm1 : 0);


As far as I can tell from a quick search, the 'histogram'
algorithm is reckoned to be about as fast as the default but
much less likely to produce terrible diffs.

  git config --global diff.algorithm histogram

should set it up as the default for all diff-producing purposes
including generating patches for email.

thanks
-- PMM
