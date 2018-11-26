Received: from eggs.gnu.org ([2001:4830:134:3::10]:47868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREo3-000612-9f
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gREo0-0000dG-2Y
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:11:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gREnz-0000cl-Su
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:11:56 -0500
Received: by mail-wm1-x343.google.com with SMTP id q26so17874613wmf.5
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 03:11:55 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-11-cota@braap.org>
	<874lc9hwe5.fsf@linaro.org> <20181123231948.GB13782@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181123231948.GB13782@flamenco>
Date: Mon, 26 Nov 2018 11:11:53 +0000
Message-ID: <87tvk43xfq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 10/48] exec: export do_tb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Nov 22, 2018 at 17:09:22 +0000, Alex Benn=C3=A9e wrote:
>>
>> Emilio G. Cota <cota@braap.org> writes:
>>
>> > This will be used by plugin code to flush the code cache as well
>> > as doing other bookkeeping in a safe work environment.
>>
>> This seems a little excessive given the plugin code could just call
>> tb_flush() directly. Wouldn't calling tb_flush after scheduling the
>> plugin_destroy be enough?
>>
>> If there is a race condition here maybe we could build some sort of
>> awareness into tb_flush as to the current run state. But having two
>> entry points to this rather fundamental action seems likely to either be
>> misused or misunderstood.
>
> We have to make sure that no callback left in the generated code is
> called once a plugin has been uninstalled. To me, using the same safe
> work window to both flush the TB and uninstall the plugin seems the
> simplest way to do this.

I still think making tb_flush() aware that it can run in an exclusive
period would be a better solution than exposing two functions for the
operation. So tb_flush could be something like:

  void tb_flush(CPUState *cpu)
  {
      if (tcg_enabled()) {
          unsigned tb_flush_count =3D atomic_mb_read(&tb_ctx.tb_flush_count=
);
          if (cpu_current_and_exclusive(cpu)) {
              do_tb_flush(RUN_ON_CPU_HOST_INT(tb_flush_count))
          } else {
              async_safe_run_on_cpu(cpu, do_tb_flush,
                                    RUN_ON_CPU_HOST_INT(tb_flush_count));
          }
      }
  }

Or possibly push that logic down into async_safe_run_on_cpu()?

--
Alex Benn=C3=A9e
