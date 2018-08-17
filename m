Received: from eggs.gnu.org ([2001:4830:134:3::10]:39369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqc0Y-0007tc-82
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fqc0V-0003gW-IL
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:29:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47508 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fqc0V-0003gJ-Dr
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:29:27 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1534419358-10932-5-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 16 Aug 2018 13:35:54 +0200")
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
	<1534419358-10932-5-git-send-email-thuth@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 17 Aug 2018 12:29:16 +0200
Message-ID: <87va89uw03.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/8] hw/timer/mc146818rtc: Fix
 introspection problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>

Thomas Huth <thuth@redhat.com> wrote:
> There is currently a funny problem with the "mc146818rtc" device:
> 1) Start QEMU like this:
>    qemu-system-ppc64 -M pseries -S
> 2) At the HMP monitor, enter "info qom-tree". Note that there is an
>    entry for "/rtc (spapr-rtc)".
> 3) Introspect the mc146818rtc device like this:
>    device_add mc146818rtc,help
> 4) Run "info qom-tree" again. The "/rtc" entry is gone now!
>
> The rtc_finalize() function of the mc146818rtc device has two bugs: First,
> it tries to remove a "rtc" property, while the rtc_realizefn() added a
> "rtc-time" property instead. And second, it should have been done in an
> unrealize function, not in a finalize function, to avoid that this causes
> problems during introspection.
>
> But since adding aliases to the global machine state should not be done
> from a device's realize function anyway, let's rather fix this issue
> by moving the creation of the alias to the code that creates the device
> (and thus is run from the machine init functions instead), i.e. the
> mc146818_rtc_init() function for most machines. The prep machines are
> special, since the mc146818rtc device is created here in the realize
> function of the i82378 device. Since we certainly don't want to add the
> alias there, we add it to some code that is called from the ibm_40p_init()
> machine init function instead.
> Since the alias is now only created during the machine init, we can remove
> the object_property_del() completely.
>
> Fixes: 654a36d857ff949e0d1989904b76f53fded9dc83
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
