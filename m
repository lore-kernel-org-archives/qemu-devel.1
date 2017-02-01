Received: from eggs.gnu.org ([2001:4830:134:3::10]:43157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYwrg-0005wP-KO
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cYwrb-0005qU-LW
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:30:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cYwrb-0005qK-FL
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:30:27 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E593946C
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 15:30:26 +0000 (UTC)
References: <1485852398-2327-1-git-send-email-thuth@redhat.com>
	<1485955513.1076.59.camel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ba960b7-4235-8036-7f48-974819775292@redhat.com>
Date: Wed, 1 Feb 2017 16:30:24 +0100
MIME-Version: 1.0
In-Reply-To: <1485955513.1076.59.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] audio/sdlaudio: Allow audio playback
 with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 01.02.2017 14:25, Gerd Hoffmann wrote:
> On Di, 2017-01-31 at 09:46 +0100, Thomas Huth wrote:
>> When compiling with SDL2, the semaphore trick used in sdlaudio.c
>> does not work - QEMU locks up completely in this case. To avoid
>> the hang and get at least some audio playback up and running (it's
>> a little bit crackling, but better than nothing), we can use the
>> SDL locking functions SDL_LockAudio() and SDL_UnlockAudio() to sync
>> with the sound playback thread instead.
>=20
> Does SDL_LockAudio work with sdl1 too?
> So we can possibly avoid having all those #ifdefs?

It somehow works, too, but sound quality is - at least for me - much
worse here than with the semaphore code. Maybe it can be fixed, too, but
I am really not familiar enough with the QEMU internal audio API to
figure out how to fix this (e.g. I don't understand why the run_out
function is called way more often than the callback function, but its
"live" parameter never reaches the full buffer size).
So maybe we can start with the #ifdefs for now and remove them once
somebody figured out how to improve sound quality for SDL1, too? (or
once we remove support for SDL1 from QEMU completely ... or do we want
to carry that with us forever?).

 Thomas
