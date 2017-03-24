Received: from eggs.gnu.org ([2001:4830:134:3::10]:43601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crLar-00078N-Hm
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1crLao-0007Av-EJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:33:13 -0400
References: <CABLmASH=JA8qh+bqNjHiAB_hwbxZ-DnA4fy5tgu8+THbwvM7zg@mail.gmail.com>
	<81b9d4e2-92b2-4ab9-8e67-faf2dee8dc81@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <25901d9c-7539-3bc6-8372-9ab04d91c95b@redhat.com>
Date: Fri, 24 Mar 2017 10:33:04 +0100
MIME-Version: 1.0
In-Reply-To: <81b9d4e2-92b2-4ab9-8e67-faf2dee8dc81@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] Bug in qemu-system-ppc in Windows using
 the SDL2 GUI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org, luigi burdo <intermediadc@hotmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 24.03.2017 09:56, Mark Cave-Ayland wrote:
> On 24/03/17 08:47, Howard Spoelstra wrote:
>=20
>> Hi,
>>
>> Running qemu-system-ppc.exe in windows with the SDL2 GUI results in a
>> hangup. I bisected to this commit:
>>
>> 8bb93c6f99a42c2e0943bc904b283cd622d302c5 is the first bad commit
>> commit 8bb93c6f99a42c2e0943bc904b283cd622d302c5
>> Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Date:   Wed Mar 15 14:48:25 2017 +0000
>>
>>     ui/console: ensure graphic updates don't race with TCG vCPUs
>>
>>     Commit 8d04fb55..
>>
>>       tcg: drop global lock during TCG code execution
>>
>>     ..broke the assumption that updates to the GUI couldn't happen at =
the
>>     same time as TCG vCPUs where running. As a result the TCG vCPU cou=
ld
>>     still be updating a directly mapped frame-buffer while the display
>>     side was updating. This would cause artefacts to appear when the
>>     update code assumed that memory block hadn't changed.
>>
>>     The simplest solution is to ensure the two things can't happen at =
the
>>     same time like the old BQL locking scheme. Here we use the solutio=
n
>>     introduced for MTTCG and schedule the update as async_safe_work wh=
en
>>     we know no vCPUs can be running.
>>
>>     Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>     Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>     Message-id: 20170315144825.3108-1-alex.bennee@linaro.org
>>     Cc: BALATON Zoltan <balaton@eik.bme.hu>
>>     Cc: Gerd Hoffmann <kraxel@redhat.com>
>>     Cc: Paolo Bonzini <pbonzini@redhat.com>
>>     Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>>     [ kraxel: updated comment clarifying the display adapters are bugg=
y
>>               and this is a temporary workaround ]
>>
>>     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Hi Howard,
>=20
> Alex posted another patch yesterday to resolve a similar issue:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg04474.html.
>=20
> Does applying the above patch help at all?

Luigi Burdo reported a similar issue here:

https://bugs.launchpad.net/qemu/+bug/1675549

Luigi, could you please try Alex' patch to see whether it fixes your cras=
h?

 Thanks,
  Thomas
