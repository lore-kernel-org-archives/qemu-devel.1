Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFjLe-00007H-7q
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fFjLd-0001sr-6r
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:50:50 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
	<87o9i5uplt.fsf@dusky.pond.sub.org>
	<20180507135330.GS25013@localhost.localdomain>
Date: Mon, 07 May 2018 18:50:35 +0200
In-Reply-To: <20180507135330.GS25013@localhost.localdomain> (Eduardo Habkost's
	message of "Mon, 7 May 2018 10:53:30 -0300")
Message-ID: <87h8njtnok.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH] tests/device-introspect: Test devices
 with all machines, not only with "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Apr 27, 2018 at 08:31:58AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > On Thu, Apr 26, 2018 at 05:20:25PM +0200, Thomas Huth wrote:
>> >> On 26.04.2018 13:45, Markus Armbruster wrote:
>> >> > Thomas Huth <thuth@redhat.com> writes:
>> >> [...]
>> >> >> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
>> >> >>      qtest_end();
>> >> >>  }
>> >> >>  
>> >> >> +static void add_machine_test_case(const char *mname)
>> >> >> +{
>> >> >> +    char *path, *args;
>> >> >> +
>> >> >> +    /* Ignore blacklisted machines */
>> >> >> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)) {
>> >> >> +        return;
>> >> >> +    }
>> >> >> +
>> >> >> +    path = g_strdup_printf("device/introspect/concrete-defaults-%s", mname);
>> >> >> +    args = g_strdup_printf("-machine %s", mname);
>> >> >> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>> >> > 
>> >> > This runs test_device_intro_concrete() with "-machine M" for all machine
>> >> > types M, in SPEED=slow mode.
>> >> > 
>> >> >> +    g_free(path);
>> >> >> +
>> >> >> +    path = g_strdup_printf("device/introspect/concrete-nodefaults-%s", mname);
>> >> >> +    args = g_strdup_printf("-nodefaults -machine %s", mname);
>> >> >> +    qtest_add_data_func(path, args, test_device_intro_concrete);
>> >> > 
>> >> > This runs test_device_intro_concrete() with "-nodefaults -machine M" for
>> >> > all machine types M, in SPEED=slow mode.
>> >> > 
>> >> > Has "without -nodefaults" exposed additional bugs?
>> >> 
>> >> After testing this with all machines, I had to discover that
>> >> "-nodefaults" does not work so easily: A lot of the embedded machines
>> >> (especially the ARM machines) simply refuse to work with "-nodefaults"
>> >> and exit immediately instead. E.g.:
>> >> 
>> >> $ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,accel=qtest
>> >> qemu-system-arm: missing SecureDigital device
>> 
>> These are all bugs.  --nodefaults is supposed to suppress *optional*
>> devices, not mandatory ones.
>
> I'm not sure I understand the requirements.  What exactly is the
> definition of "mandatory"?
>
> A machine created by "qemu-system-x86_64 -machine pc -nodefaults"
> is useless because it has no any device to boot from.  How is
> that different from a n810 machine not booting because there's no
> SD device?

I propose:

* Stuff that's required for QEMU to run is not suppressed by -nodefaults

* Stuff that a real machine has soldered on is also not suppressed

* Stuff that can be pulled out of a real machine may be suppressed, even
  when that means the guest won't run

Does that make some sense?
