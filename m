Received: from eggs.gnu.org ([209.51.188.92]:34865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gi2QZ-0008PL-3j
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:25:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gi2QY-0006Hd-Dw
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:25:11 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gi2QY-0006GS-63
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:25:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so16384494wrt.7
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 11:25:09 -0800 (PST)
References: <20190111143815.26107-1-alex.bennee@linaro.org>
	<89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
	<87sgxzusb7.fsf@linaro.org>
	<3b4aa1f9-c18a-e2d7-abdd-f688bed9f4a1@redhat.com>
	<20190111193254.15849683@bahia.lan>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190111193254.15849683@bahia.lan>
Date: Fri, 11 Jan 2019 19:25:07 +0000
Message-ID: <87k1jbuhd8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests: replace rem = sleep(time) with
 g_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, cota@braap.org, qemu-devel@nongnu.org, ehabkost@redhat.com


Greg Kurz <groug@kaod.org> writes:

> On Fri, 11 Jan 2019 16:41:41 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> On 11/01/19 16:28, Alex Benn=C3=A9e wrote:
>> >> Why not g_usleep?  It already does a while loop around nanosleep (whi=
ch
>> >> returns the remaining time in the wait, like select but unlike sleep =
and
>> >> poll).
>> > Yeah I'm testing that now. However I have managed to trigger:
>> >
>> >   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D =
0): (35584 =3D=3D 0)
>>
>> I think that's a good old SIGSEGV (0x8B00).
>>
>
> Hmmm... system() returns a "wait status" that can  be examined using the
> macros described in waitpid(2), and we have:
>
> /* If WIFEXITED(STATUS), the low-order 8 bits of the status.  */
> #define	__WEXITSTATUS(status)	(((status) & 0xff00) >> 8)
>
> So this rather looks like a 139 exit status to me... Not sure how
> this can happen though.

Yeah the child segfaulted in mcount while closing down. I've started a
new thread with the details of the remaining failure modes:

  Subject: Remaining CI failures
  Date: Fri, 11 Jan 2019 19:10:07 +0000
  Message-ID: <87lg3rui28.fsf@linaro.org>


--
Alex Benn=C3=A9e
