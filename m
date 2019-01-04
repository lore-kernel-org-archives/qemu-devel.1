Received: from eggs.gnu.org ([208.118.235.92]:45951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfNEa-0003QW-Sq
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfNEW-0000SG-NW
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:01:48 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:52756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfNEU-0000Q6-Th
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:01:44 -0500
Received: by mail-wm1-f43.google.com with SMTP id m1so789486wml.2
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 03:01:41 -0800 (PST)
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
	<CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
	<bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
	<CAFEAcA9tiqHEiCdUXWcD+SvzUzZPG4sTqiTSR57N=qYM49eykw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8bb4435-7b69-04e9-2b4a-4cfdd439ecea@redhat.com>
Date: Fri, 4 Jan 2019 12:01:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9tiqHEiCdUXWcD+SvzUzZPG4sTqiTSR57N=qYM49eykw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 04/01/19 11:06, Peter Maydell wrote:
> On Fri, 4 Jan 2019 at 07:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 03/01/19 19:37, Peter Maydell wrote:
>>> On Sat, 22 Dec 2018 at 08:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> Interestingly, I have today run into "make: write error: stdout"
>>> with the existing make check infrastructure. [...]
>>> I presume that something in one of the tests we're running,
>>> likely QEMU itself, ends up setting stdout to non-blocking.
>>> This while rune *used* to be entirely reliable, so maybe
>>> something recent has changed ?
>>
>> I don't know... I tried running make check under "strace -e fcntl" and I
>> didn't find any occurrences of fcntl(1, O_SETFL, ...|O_NONBLOCK).
>> Perhaps you can add a check after every invocation of a test executable.
> 
>> Are you going to apply the pull request since the bug is preexisting?
> 
> The pull request takes the problem from "occasionally shows up
> in by-hand running of make check in a while loop" to "reliably
> causes my automated tests to fail every time". I can't apply
> a pullreq that does that, so we need to find at least a workaround.

The certain workaround is to clear O_NONBLOCK before invoking make,
possibly by placing a wrapper in ~/bin:

    import os
    from fcntl import *
    fcntl(1, F_SETFL, fcntl(1, F_GETFL) & ~os.O_NONBLOCK)

If you're using --output-sync, *not* using it might work, but not if the
write error occurs when writing the command (as opposed to the output).
 For what it's worth, I think the latest version of Make is still
susceptible when using --output-sync.  The loop that flushes the
temporary buffer to stdout or stderr is as follows:

  while (1)
    {
      int len;
      EINTRLOOP (len, read (from, buffer, sizeof (buffer)));
      if (len < 0)
        perror ("read()");
      if (len <= 0)
        break;
      if (fwrite (buffer, len, 1, to) < 1)
        {
          perror ("fwrite()");
          break;
        }
      fflush (to);
    }

Maybe it's one of the dependencies of QEMU that is causing it.


Paolo

> I'm not sure why your test harness makes it much more likely
> that the problem manifests.
