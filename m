Received: from eggs.gnu.org ([2001:4830:134:3::10]:50991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzI4Q-0004cQ-B6
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzI4K-0000Mi-EU
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:01:22 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:53068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzI4J-0000J6-Qk
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 05:01:16 -0400
Received: by mail-wm0-x243.google.com with SMTP id y139-v6so20549349wmc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 02:01:15 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<87lg8dz809.fsf@linaro.org>
	<CAFEAcA-iTfGnjc+0ndTMxZ=RYRCK3_RRmE1RCNgDnTVL_brrXQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-iTfGnjc+0ndTMxZ=RYRCK3_RRmE1RCNgDnTVL_brrXQ@mail.gmail.com>
Date: Mon, 10 Sep 2018 10:01:12 +0100
Message-ID: <87h8ixd8vb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation
 prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, maria.klimushenkova@ispras.ru, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Llu?= =?utf-8?Q?=C3=ADs?= Vilanova <vilanova@ac.upc.edu>


Peter Maydell <peter.maydell@linaro.org> writes:

<snip>
>> Now I can see arguments against it from an interface complexity point of
>> view but I think plugins should get access to the TCG functions so they
>> can generate their own op sequences if need be and not have to call a
>> helper at all if they don't need to.
>
> I strongly disagree -- plugins should not have access to details
> of QEMU internals that might change from version to version, and
> definitely not access to generating their own TCG code.

The problem is I think a simple single helper with a PC and a CPU env is
fairly inflexible and inefficient. It would also make the API simpler if
we could leave the decision about installing the helper to the
instrumentation function. However I take your point that exposing the
whole TCG API might be a bit too much. Perhaps the qmeulib functions
could wrap enough so we could have an instrumentation function like
this:

  void plugins_instrument_before_insn(target_ulong disas_pc)
  {
      TCGv t_pc =3D qemulib_make_const(pc);
      qemulib_call_helper1(pc);
  }

By marshalling through qemulib we could keep track of temps allocated
and do the clean-up for the plugin or take the approach that plugin
writers need to have some idea of what they are doing.

In terms of the wider problem about exposing internals that might change
from version to version I wonder if we should care? Is the plugin API
one where we should provide ABI stability or should we take the approach
that Linux does and say if your code lives out-of-tree then it's your
problem to keep up if/when we change.

--
Alex Benn=C3=A9e
