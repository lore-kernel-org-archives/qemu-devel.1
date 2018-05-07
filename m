Received: from eggs.gnu.org ([2001:4830:134:3::10]:46639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFls5-000746-IP
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFls4-0000zN-8G
	for qemu-devel@nongnu.org; Mon, 07 May 2018 15:32:29 -0400
Date: Mon, 7 May 2018 16:32:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507193220.GF25013@localhost.localdomain>
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87bme62nu0.fsf@dusky.pond.sub.org>
	<068649bc-1546-6fc5-3e41-63512196cbf8@redhat.com>
	<20180427003215.GU29865@localhost.localdomain>
	<87o9i5uplt.fsf@dusky.pond.sub.org>
	<20180507135330.GS25013@localhost.localdomain>
	<87h8njtnok.fsf@dusky.pond.sub.org>
	<20180507182126.GC25013@localhost.localdomain>
	<4bba0be5-a52c-48ad-3df4-4e9be3624dc0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bba0be5-a52c-48ad-3df4-4e9be3624dc0@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Mon, May 07, 2018 at 09:13:57PM +0200, Thomas Huth wrote:
> On 07.05.2018 20:21, Eduardo Habkost wrote:
> > On Mon, May 07, 2018 at 06:50:35PM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>
> >>> On Fri, Apr 27, 2018 at 08:31:58AM +0200, Markus Armbruster wrote:
> >>>> Eduardo Habkost <ehabkost@redhat.com> writes:
> >>>>
> >>>>> On Thu, Apr 26, 2018 at 05:20:25PM +0200, Thomas Huth wrote:
> >>>>>> On 26.04.2018 13:45, Markus Armbruster wrote:
> >>>>>>> Thomas Huth <thuth@redhat.com> writes:
> >>>>>> [...]
> >>>>>>>> @@ -260,6 +263,26 @@ static void test_abstract_interfaces(void)
> >>>>>>>>      qtest_end();
> >>>>>>>>  }
> >>>>>>>>  
> >>>>>>>> +static void add_machine_test_case(const char *mname)
> >>>>>>>> +{
> >>>>>>>> +    char *path, *args;
> >>>>>>>> +
> >>>>>>>> +    /* Ignore blacklisted machines */
> >>>>>>>> +    if (g_str_equal("xenfv", mname) || g_str_equal("xenpv", mname)) {
> >>>>>>>> +        return;
> >>>>>>>> +    }
> >>>>>>>> +
> >>>>>>>> +    path = g_strdup_printf("device/introspect/concrete-defaults-%s", mname);
> >>>>>>>> +    args = g_strdup_printf("-machine %s", mname);
> >>>>>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
> >>>>>>>
> >>>>>>> This runs test_device_intro_concrete() with "-machine M" for all machine
> >>>>>>> types M, in SPEED=slow mode.
> >>>>>>>
> >>>>>>>> +    g_free(path);
> >>>>>>>> +
> >>>>>>>> +    path = g_strdup_printf("device/introspect/concrete-nodefaults-%s", mname);
> >>>>>>>> +    args = g_strdup_printf("-nodefaults -machine %s", mname);
> >>>>>>>> +    qtest_add_data_func(path, args, test_device_intro_concrete);
> >>>>>>>
> >>>>>>> This runs test_device_intro_concrete() with "-nodefaults -machine M" for
> >>>>>>> all machine types M, in SPEED=slow mode.
> >>>>>>>
> >>>>>>> Has "without -nodefaults" exposed additional bugs?
> >>>>>>
> >>>>>> After testing this with all machines, I had to discover that
> >>>>>> "-nodefaults" does not work so easily: A lot of the embedded machines
> >>>>>> (especially the ARM machines) simply refuse to work with "-nodefaults"
> >>>>>> and exit immediately instead. E.g.:
> >>>>>>
> >>>>>> $ arm-softmmu/qemu-system-arm -nodefaults -nographic -M n810,accel=qtest
> >>>>>> qemu-system-arm: missing SecureDigital device
> >>>>
> >>>> These are all bugs.  --nodefaults is supposed to suppress *optional*
> >>>> devices, not mandatory ones.
> >>>
> >>> I'm not sure I understand the requirements.  What exactly is the
> >>> definition of "mandatory"?
> >>>
> >>> A machine created by "qemu-system-x86_64 -machine pc -nodefaults"
> >>> is useless because it has no any device to boot from.  How is
> >>> that different from a n810 machine not booting because there's no
> >>> SD device?
> >>
> >> I propose:
> >>
> >> * Stuff that's required for QEMU to run is not suppressed by -nodefaults
> >>
> >> * Stuff that a real machine has soldered on is also not suppressed
> >>
> >> * Stuff that can be pulled out of a real machine may be suppressed, even
> >>   when that means the guest won't run
> > 
> > Makes sense to me.  It looks like the only obstacle for
> > tests/device-introspect and device-crash-test is the first rule.
> > "Guest won't boot" isn't a problem, but "QEMU won't run" is.
> > 
> > The first rule is easily testable, too: running
> > "$QEMU -machine $MACHINE -nodefaults" and not having a working
> > QMP monitor should be reported as a bug by automated tests.
> 
> You mean with "-accel qtest" or without? With "-accel qtest" we should
> pretty soon be fine, after Peter's current PULL request has been merged
> (which contains a patch from me for fixing these SD card problems with
> ARM machines).
> Without "-accel qtest", things are not that easy, unfortunately. Lots of
> boards require "-kernel" or "-bios" and refuse to work without. So you
> can hardly test "-nodefaults" automatically in the normal tcg mode. (But
> maybe all boards should allow to start QEMU in case you've at least also
> specified "-S" ? ... in that case we've got plenty of work for
> BiteSizeTasks ;-) )

Hmm, maybe it's not a bite-sized task after all.  :)

Should we do this gradually?

* Working with -accel qtest is useful, and sounds like an easier goal;
* working with -S seems desirable too;
* working without -S (even if the emulated CPU crashes and burns)
  would be interesting.

Related question: what are the use cases where we require
"-accel qtest" and "-S" wouldn't work?

Are the requirements and goals of "-accel qtest" documented
somewhere?  Without documentation, it's hard to say when a given
qtest_enabled() call in the code is reasonable, or a hack we want
to get rid of.

-- 
Eduardo
