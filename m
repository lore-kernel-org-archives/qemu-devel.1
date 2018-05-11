Received: from eggs.gnu.org ([2001:4830:134:3::10]:42093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fH4n3-0008Gp-KI
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fH4n0-0003M3-IB
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:56:41 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52092)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fH4n0-0003Lf-AO
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:56:38 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <1446725643-82458-1-git-send-email-pbonzini@redhat.com>
	<1446725643-82458-3-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8xPCQpXYPPbfizzXZ-7OzUXGUN4dyqrbM3_Vy27coDKw@mail.gmail.com>
	<8a22efa3-94a0-5ffa-17df-45702601624d@redhat.com>
In-Reply-To: <8a22efa3-94a0-5ffa-17df-45702601624d@redhat.com>
Date: Fri, 11 May 2018 12:56:34 +0300
Message-ID: <002501d3e90e$587457f0$095d07d0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PULL 02/18] replay: internal functions for replay
 log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'QEMU Developers' <qemu-devel@nongnu.org>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 11/05/2018 11:27, Peter Maydell wrote:
> >> +uint8_t replay_get_byte(void)
> >> +{
> >> +    uint8_t byte = 0;
> >> +    if (replay_file) {
> >> +        byte = getc(replay_file);
> >> +    }
> >> +    return byte;
> >> +}
> > Coverity (CID 1390576) points out that this function isn't checking
> > the error return from getc(). That means we could incorrectly return
> > 255 from here and then the return value from replay_get_dword would
> > be 0xffffffff, which is unfortunate if the place that's using
> > that uses it as a loop boundary.
> 
> Thanks!  Pavel can you check it?  How is error checking done in general
> for record/replay, should QEMU exit immediately?

Yes, usually there is no sense continuing the replayed execution
in case of an io error. Therefore closing QEMU is fine.

Pavel Dovgalyuk
