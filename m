Received: from eggs.gnu.org ([2001:4830:134:3::10]:52603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dxvA4-0002DV-Kh
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dxvA1-0002Ac-Gv
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:17:00 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:48315)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dxvA1-00029q-63
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 09:16:57 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan>
Date: Fri, 29 Sep 2017 16:16:41 +0300
In-Reply-To: <87o9pywt8k.fsf@frigg.lan> (=?utf-8?Q?=22Llu=C3=ADs?=
	Vilanova"'s message of "Mon, 25 Sep 2017 21:03:39 +0300")
Message-ID: <87shf5zlty.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Llu=C3=ADs Vilanova writes:
[...]
> This was working on a much older version of instrumentation for QEMU, but=
 I can
> implement something that does the first use-case point above and some fil=
tering
> example (second use-case point) to see what's the performance difference.

Ok, so here's some numbers for the discussion (booting Emilio's ARM full sy=
stem
image that immediately shuts down):

* Without instrumentation

  real	0m10,099s
  user	0m9,876s
  sys	0m0,128s

* Count number of memory access writes, by instrumenting only when they are
  executed

  real	0m15,896s
  user	0m15,752s
  sys	0m0,108s

* Counting same, but the filtering is done at translation time (i.e., not
  generate an execute-time callback if it's not a write)

  real	0m11,084s
  user	0m10,880s
  sys	0m0,112s

  As Peter said, the filtering can be added into the API to take advantage =
of
  this "speedup", without exposing translation vs execution time callbacks.

* Counting number of executed instructions, by instrumenting the beginning =
of
  each one of them

  real	0m24,583s
  user	0m24,352s
  sys	0m0,184s

* Counting same, but per-TB numbers are collected at translation-time, and =
we
  only generate a per-TB execution time callback to add the corresponding n=
umber
  of instructions for that TB

  real	0m11,151s
  user	0m10,952s
  sys	0m0,092s

  This really needs to expose translation vs execution time callbacks to ta=
ke
  advantage of this "speedup".

Cheers,
  Lluis
