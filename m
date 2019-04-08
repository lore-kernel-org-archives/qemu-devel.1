Received: from eggs.gnu.org ([209.51.188.92]:60164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hDRjO-0000va-Ff
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hDRjN-0002pe-Ki
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:42:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hDRjN-0002pC-As
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:42:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6CF9C3092661
	for <qemu-devel@nongnu.org>; Mon,  8 Apr 2019 10:42:23 +0000 (UTC)
References: <20190326131822.GD15011@stefanha-x1.localdomain>
	<55751c00-0854-ea4d-75b5-ab82b4eeb70d@redhat.com>
	<877ec8mmy9.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14b7dab8-5c4b-a8e4-c3c3-8e931171747a@redhat.com>
Date: Mon, 8 Apr 2019 12:42:00 +0200
MIME-Version: 1.0
In-Reply-To: <877ec8mmy9.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU event loop optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 05/04/19 18:33, Sergio Lopez wrote:
>> - qemu_bh_schedule_nested should not be necessary since we have=20
>> ctx->notify_me to also avoid the event_notifier_set call.  However, it=
=20
>> is possible to avoid the smp_mb at the beginning of aio_notify, since =
=20
>> atomic_xchg already implies it.  Maybe add a "static void=20
>> aio_notify__after_smp_mb"?
> try_poll_mode() is called with ctx->notify_me !=3D 0, so we get at leas=
t
> one event_notifier_set() call while working in polling mode.

Right, though then there is the idea of making ctx->notify_me and
ctx->notified bitmasks, where bit 0 is "BH ready" and bit 1 is "poll()
parameters changed".  try_poll_mode() cares about the latter, but does
not need event_notifier_set() for BH ready.

Paolo
