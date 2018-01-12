Received: from eggs.gnu.org ([2001:4830:134:3::10]:44454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZsa7-0008Vs-TX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZsa2-0000cO-Vi
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:12:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:56450)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZsa2-0000bv-Ms
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 01:12:42 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<20180111082514.27295.13900.stgit@pasha-VirtualBox>
	<1a1c19d4-d48d-1d12-fc77-ab9657ef4271@redhat.com>
In-Reply-To: <1a1c19d4-d48d-1d12-fc77-ab9657ef4271@redhat.com>
Date: Fri, 12 Jan 2018 09:12:43 +0300
Message-ID: <001201d38b6c$5c1c1730$14544590$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v3 03/30] This patch adds a condition
 before overwriting exception_index fields.
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
> On 11/01/2018 09:25, Pavel Dovgalyuk wrote:
> > It is needed when exception_index is already set to some meaningful value.
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  accel/tcg/cpu-exec.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 280200f..9cc6972 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -585,6 +585,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >          else {
> >              if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
> >                  replay_interrupt();
> > +                cpu->exception_index = -1;
> >                  *last_tb = NULL;
> >              }
> >              /* The target hook may have updated the 'cpu->interrupt_request';
> > @@ -606,7 +607,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
> >      if (unlikely(atomic_read(&cpu->exit_request)
> >          || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
> >          atomic_set(&cpu->exit_request, 0);
> > -        cpu->exception_index = EXCP_INTERRUPT;
> > +        if (cpu->exception_index == -1) {
> > +            cpu->exception_index = EXCP_INTERRUPT;
> > +        }
> >          return true;
> >      }
> >
> >
> 
> Where does my S-o-b come from? :)

Because you proposed first version of this code, I think.


Pavel Dovgalyuk
