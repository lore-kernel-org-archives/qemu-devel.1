Received: from eggs.gnu.org ([2001:4830:134:3::10]:36600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fB0gQ-0001rM-8i
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fB0gM-0002VS-7k
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:20:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fB0gL-0002V6-Qo
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 12:20:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-16-git-send-email-ian.jackson@eu.citrix.com>
	<b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org>
Date: Tue, 24 Apr 2018 18:20:38 +0200
In-Reply-To: <b8d20908-c76c-1dc2-2c14-31c185abbbfc@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	19 Apr 2018 17:31:50 -0300")
Message-ID: <87po2obmp5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/16] os-posix: cleanup: Replace perror
 with error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis <alistair.francis@xilinx.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 04/19/2018 01:45 PM, Ian Jackson wrote:
>> perror() is defined to fprintf(stderr,...).  HACKING says
>> fprintf(stderr,...) is wrong.  So perror() is too.
>>=20
>> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
>> CC: Paolo Bonzini <pbonzini@redhat.com>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Daniel P. Berrange <berrange@redhat.com>
>> CC: Michael Tokarev <mjt@tls.msk.ru>
>> CC: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>> v7: New patch
>> ---
>>  os-posix.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/os-posix.c b/os-posix.c
>> index d4cf466..0108028 100644
>> --- a/os-posix.c
>> +++ b/os-posix.c
>> @@ -125,7 +125,7 @@ void os_set_proc_name(const char *s)
>>      /* Could rewrite argv[0] too, but that's a bit more complicated.
>>         This simple way is enough for `top'. */
>>      if (prctl(PR_SET_NAME, name)) {
>> -        perror("unable to change process name");
>> +        error_report("unable to change process name: %s", strerror(errn=
o));
>>          exit(1);
>>      }
>>  #else
>> @@ -247,7 +247,7 @@ static void change_root(void)
>>              exit(1);
>>          }
>>          if (chdir("/")) {
>> -            perror("not able to chdir to /");
>> +            error_report("not able to chdir to /: %s", strerror(errno));
>>              exit(1);
>>          }
>>      }
>> @@ -309,7 +309,7 @@ void os_setup_post(void)
>>=20=20
>>      if (daemonize) {
>>          if (chdir("/")) {
>> -            perror("not able to chdir to /");
>> +            error_report("not able to chdir to /: %s", strerror(errno));
>>              exit(1);
>>          }
>>          TFR(fd =3D qemu_open("/dev/null", O_RDWR));
>> @@ -383,7 +383,7 @@ int os_mlock(void)
>>=20=20
>>      ret =3D mlockall(MCL_CURRENT | MCL_FUTURE);
>>      if (ret < 0) {
>> -        perror("mlockall");
>> +        error_report("mlockall: %s", strerror(errno));
>>      }
>>=20=20
>>      return ret;
>
> Thinking loudly, maybe we can refactor as error_report_errno(const char
> *desc)...

Maybe.  If you want to try, make it a separate series not blocking this
one.

> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
