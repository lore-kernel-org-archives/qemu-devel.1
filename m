Received: from eggs.gnu.org ([2001:4830:134:3::10]:51139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpAIZ-0005uU-Aj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpAIU-0005kU-I7
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:37:35 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpAIU-0005jO-AE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:37:30 -0400
Received: by mail-wm0-x231.google.com with SMTP id h144so2551884wme.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:37:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905092230.8243-1-berrange@redhat.com>
References: <20170905092230.8243-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 10:37:08 +0100
Message-ID: <CAFEAcA92RBgkvKQ-6DGgRFr-bxz_60zbXSuQ1AGtz1eUuX_rYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/9] Merge QEMU I/O 2017/09/05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 10:22, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit 32f0f68bb77289b75a82925f712bb52e16eac3ba:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-09-01 17:28:54 +0100)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-20170905-1
>
> for you to fetch changes up to 33fb97121573985b4a57306b8abdb9dd992061fa:
>
>   io: fix check for handshake completion in TLS test (2017-09-05 10:20:28 +0100)
>
> ----------------------------------------------------------------
> Merge QEMU I/O 2017/09/05 v1
>
> ----------------------------------------------------------------

I get a build failure with this I'm afraid:

FreeBSD:
/root/qemu/tests/test-listen.c:53:19: error: use of undeclared
identifier 'EAI_ADDRFAMILY'
        if (rc == EAI_ADDRFAMILY ||
                  ^

and test-listen fails on my x86-64 Linux box:
  GTESTER tests/test-listen
** Failed to assign a port to thread 0 (errno = 98)
** Failed to assign a port to thread 1 (errno = 98)
** Failed to assign a port to thread 2 (errno = 98)
** Failed to assign a port to thread 3 (errno = 98)
** Failed to assign a port to thread 4 (errno = 98)
** Failed to assign a port to thread 5 (errno = 98)
** Failed to assign a port to thread 6 (errno = 98)
[snip 7..96 same message]
** Failed to assign a port to thread 97 (errno = 98)
** Failed to assign a port to thread 98 (errno = 98)
** Failed to assign a port to thread 99 (errno = 98)
** Failed to assign a port to thread 100 (errno = 110)
** Failed to assign a port to thread 101 (errno = 110)
** Failed to assign a port to thread 102 (errno = 110)
** Failed to assign a port to thread 103 (errno = 110)
[snip more with =110 message]
** Failed to assign a port to thread 198 (errno = 110)
** Failed to assign a port to thread 199 (errno = 110)
**
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (200 == 0)
GTester: last random seed: R02S501c6ff1c5ff42cf11b1318e0de42bc5

(98 is EADDRINUSE and 110 is ETIMEDOUT I think.)

aarch64 host fails sort of similarly:
TEST: tests/test-listen... (pid=12632)
  /socket/listen-serial/ipv4:                                          OK
  /socket/listen-serial/ipv6:
** Failed to assign a port to th
read 0 (errno = 98)
** Failed to assign a port to thread 1 (errno = 98)
** Failed to assign a port to thread 2 (errno = 98)
[snip]
** Failed to assign a port to thread 199 (errno = 98)
**
ERROR:/home/peter.maydell/qemu/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (200 == 0)
FAIL
GTester: last random seed: R02Sbd34929fe0b3304c2873c42c94643648
(pid=12634)
  /socket/listen-serial/generic:                                       OK
  /socket/listen-compete/ipv4:                                         OK
  /socket/listen-compete/ipv6:                                         OK
  /socket/listen-compete/generic:                                      OK
FAIL: tests/test-listen

except that it's errno 98 all the way through.

thanks
-- PMM
