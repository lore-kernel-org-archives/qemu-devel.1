Received: from eggs.gnu.org ([2001:4830:134:3::10]:39511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0hPq-0000Zm-Tm
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0hPn-0001hX-2Y
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:17:18 -0400
Received: from mail.ispras.ru ([83.149.199.45]:43248)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g0hPm-0001dX-Ov
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:17:14 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180912081747.3228.21861.stgit@pasha-VirtualBox>
	<20180912081956.3228.17903.stgit@pasha-VirtualBox>
	<b0deae03-cfdf-85c0-4262-884a1e07e5a3@redhat.com>
	<000901d44b52$c1bdcd30$45396790$@ru>
	<988eaaac-f2cc-69a7-c4c4-cdf63afd65e8@redhat.com>
In-Reply-To: <988eaaac-f2cc-69a7-c4c4-cdf63afd65e8@redhat.com>
Date: Fri, 14 Sep 2018 09:17:09 +0300
Message-ID: <002201d44bf2$92077c80$b6167580$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v6 22/25] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 13/09/2018 13:13, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> On 12/09/2018 10:19, Pavel Dovgalyuk wrote:
> >>> + uint64_t id = replay_get_current_step();
> >>> + replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
> >>
> >> Why does it need an id, while REPLAY_ASYNC_EVENT_BH does not?
> >
> > Because _oneshot() function takes only context and callback,
> > and BH object is created inside that function.
> > Therefore to use the normal bh scheduling events we have to refactor
> > block code - add bh creation, scheduling, and freeing.
> 
> No, I'm asking only why the id is 0 for REPLAY_ASYNC_EVENT_BH and
> replay_get_current_step() for REPLAY_ASYNC_EVENT_BH_ONESHOT.
> 
> Thanks,
> 
> Paolo

Sorry, I missed your point.
Maybe you looked at the wrong function, because both of these events have an id:

void replay_bh_schedule_event(QEMUBH *bh)
{
    if (events_enabled) {
        uint64_t id = replay_get_current_step();
        replay_add_event(REPLAY_ASYNC_EVENT_BH, bh, NULL, id);
    } else {
        qemu_bh_schedule(bh);
    }
}

void replay_bh_schedule_oneshot_event(AioContext *ctx,
    QEMUBHFunc *cb, void *opaque)
{
    if (events_enabled) {
        uint64_t id = replay_get_current_step();
        replay_add_event(REPLAY_ASYNC_EVENT_BH_ONESHOT, cb, opaque, id);
    } else {
        aio_bh_schedule_oneshot(ctx, cb, opaque);
    }
}

Pavel Dovgalyuk
