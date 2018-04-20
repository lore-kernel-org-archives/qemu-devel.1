Received: from eggs.gnu.org ([2001:4830:134:3::10]:37128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Yer-000725-Kl
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Yeo-0007zI-Gp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:13:09 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9Yeo-0007yx-9u
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:13:06 -0400
Received: by mail-wr0-x242.google.com with SMTP id v24-v6so24356506wra.8
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 09:13:06 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
	<1522980788-1252-15-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1522980788-1252-15-git-send-email-cota@braap.org>
Date: Fri, 20 Apr 2018 17:13:03 +0100
Message-ID: <87k1t1amb4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/17] translate-all: protect TB jumps
 with a per-destination-TB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> This applies to both user-mode and !user-mode emulation.
>
> Instead of relying on a global lock, protect the list of incoming
> jumps with tb->jmp_lock. This lock also protects tb->cflags,
> so update all tb->cflags readers outside tb->jmp_lock to use
> atomic reads via tb_cflags().
>
> In order to find the destination TB (and therefore its jmp_lock)
> from the origin TB, we introduce tb->jmp_dest[].
>
> I considered not using a linked list of jumps, which simplifies
> code and makes the struct smaller. However, it unnecessarily increases
> memory usage, which results in a performance decrease. See for
> instance these numbers booting+shutting down debian-arm:
>                       Time (s)  Rel. err (%)  Abs. err (s)  Rel. slowdown=
 (%)
> -------------------------------------------------------------------------=
-----
>  before                  20.88          0.74      0.154512               =
  0.
>  after                   20.81          0.38      0.079078        -0.3352=
4904
>  GTree                   21.02          0.28      0.058856         0.6704=
9808
>  GHashTable + xxhash     21.63          1.08      0.233604          3.591=
9540
>
> Using a hash table or a binary tree to keep track of the jumps
> doesn't really pay off, not only due to the increased memory usage,
> but also because most TBs have only 0 or 1 jumps to them. The maximum
> number of jumps when booting debian-arm that I measured is 35, but
> as we can see in the histogram below a TB with that many incoming jumps
> is extremely rare; the average TB has 0.80 incoming jumps.
>
> n_jumps: 379208; avg jumps/tb: 0.801099
> dist: [0.0,1.0)|=E2=96=84=E2=96=88=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=
=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=E2=
=96=81=E2=96=81=E2=96=81=E2=96=81=E2=96=81 =E2=96=81=E2=96=81=E2=96=81  =E2=
=96=81=E2=96=81=E2=96=81     =E2=96=81|[34.0,35.0]
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

This now conflicts with master

--
Alex Benn=C3=A9e
