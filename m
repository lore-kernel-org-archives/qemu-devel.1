Received: from eggs.gnu.org ([2001:4830:134:3::10]:45353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cOmyl-0007iv-80
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:55:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1cOmyi-0005h1-1V
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:55:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1cOmyh-0005gC-Rw
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:55:47 -0500
Date: Wed, 4 Jan 2017 15:55:42 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20170104145541.GI2395@potion>
References: <1483266886-25050-1-git-send-email-peterx@redhat.com>
	<1483266886-25050-3-git-send-email-peterx@redhat.com>
	<20170102201824.GA2892@potion>
	<20170103024501.GA22664@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170103024501.GA22664@pxdev.xzpeter.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

2017-01-03 10:45+0800, Peter Xu:
> On Mon, Jan 02, 2017 at 09:18:24PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 w=
rote:
>> 2017-01-01 18:34+0800, Peter Xu:
>> > diff --git a/scripts/functions.bash b/scripts/functions.bash
>> Couldn't the queue be much simpler ...
>>=20
>> > +	else
>> > +		RUNTIME_log_file=3D$ut_default_log_file
>> > +		"$@"
>> > +	fi
>> >  }
>> > =20
>> >  function for_each_unittest()
>> > @@ -51,5 +62,10 @@ function for_each_unittest()
>> >  		fi
>> >  	done
>>=20
>> ... like this:
>>=20
>>   while [ "`jobs | wc -l`" -gt $ut_run_queues ]; do

(Uh, should be -ge, and `wc -l` always has reasonable output, so quotes
 are not necessary.  Quotes would make more sense around the variable.)

>>     wait
>=20
> I suppose you mean "wait -n" here?

Yes, sorry.

>                                    And also a "if" should suffice
> here, though a "while" won't hurt as well.

I agree.

(I was lazy to read the manual to confirm, hence the first mistake as
 well.  I just remembered that bash wait has this weird behavior and
 assumed that the wait in task_enqueue is already doing that ...)

>>   done
>>   run_task "$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arc=
h" "$check" "$accel" "$timeout" &
>=20
> I think this might work, however it has assumption that these $cmd
> tasks are the only jobs that is running in the background.

Yes, but run_task is already in a sub shell, so its jobs don't matter
and we can easily guarantee that for_each_unit_test won't spawn more.

> I didn't notice the "-n" parameter for "wait", otherwise I won't
> bother using SIGUSR1 at all. :)

(Btw. why couldn't you use SIGCHLD?)
