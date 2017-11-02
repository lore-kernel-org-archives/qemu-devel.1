Received: from eggs.gnu.org ([2001:4830:134:3::10]:40348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eADbz-0002lT-2i
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eADbu-0001b6-5E
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:24:39 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57118)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eADbt-0001aB-TB
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:24:34 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
In-Reply-To: <a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
Date: Thu, 2 Nov 2017 14:24:34 +0300
Message-ID: <001501d353cd$29099010$7b1cb030$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 31/10/2017 12:26, Pavel Dovgalyuk wrote:
> > This patch resets icount_decr.u32.high before calling cpu_exec_nocache
> > when exception is pending. Exception is caused by the first instruction
> > in the block and it cannot be executed without resetting the flag.
> >
> > Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >
> > ---
> >  accel/tcg/cpu-exec.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 35d0240..aaa9c2d 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -500,6 +500,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
> >      } else if (replay_has_exception()
> >                 && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
> >          /* try to cause an exception pending in the log */
> > +        atomic_set(&cpu->icount_decr.u16.high, 0);
> >          cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0, curr_cflags()), true);
> >          *ret = -1;
> >          return true;
> >
> 
> I am not sure about this.  I think if instead you should return false
> from here and EXCP_INTERRUPT from cpu_exec.

The problem is inside the TB. It checks cpu->icount_decr.u16.high which is -1.
And we have to enter the TB to cause an exception (because it exists in replay log).
That is why we reset this flag and try to execute the TB.

> More important: there is still a race, because high can be set to -1
> right after your atomic_set.

I'm not sure about it. But even the race exists, exec_nocache attempt will be repeated
after failed try.

Returning true is ok here, because we know that exception will happen (because it is
recorded in the log).

Pavel Dovgalyuk
