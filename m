Received: from eggs.gnu.org ([2001:4830:134:3::10]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmiLW-0005H2-Tq
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmiLV-0007y7-T5
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:22:30 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:34603)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dmiLV-0007xy-O3
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:22:29 -0400
Received: by mail-vk0-x244.google.com with SMTP id l132so1448128vke.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:22:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170829180219-mutt-send-email-mst@kernel.org>
References: <20170829144805.28872-1-marcandre.lureau@redhat.com>
	<20170829144805.28872-3-marcandre.lureau@redhat.com>
	<20170829180219-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Aug 2017 17:22:28 +0200
Message-ID: <CAJ+F1CLnwVRAKLPW8xBNCe0Asjh+BVuZXHA0WLDtpYpGWim9Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user-bridge: fix resume
 regression (since 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Victor Kaplansky <victork@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Aug 29, 2017 at 5:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Aug 29, 2017 at 04:48:05PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Commit e10e798c85c2331 switched to libvhost-user which lacked support
>> for resuming the avail_idx based on used_idx.
>>
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1485867
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Can we add a test for reconnect to catch the regression?

There is no automated tests for vhost-user-bridge yet. We could
probably make one based on "[PATCH v2 0/5] tests/pxe-test: add
testcase using vhost-user-bridge" series.

We could also add seperate libvhost-user tests, that's not existent
yet, partly because libvhost-user was born as a test itself ;).

>
>> ---
>>  tests/vhost-user-bridge.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
>> index 1e5b5ca3da..dca48512ba 100644
>> --- a/tests/vhost-user-bridge.c
>> +++ b/tests/vhost-user-bridge.c
>> @@ -466,11 +466,18 @@ vubr_panic(VuDev *dev, const char *msg)
>>      vubr->quit =3D 1;
>>  }
>>
>> +static bool
>> +vubr_queue_resume_to_used(VuDev *dev, int qidx)
>> +{
>> +    return true;
>> +}
>> +
>>  static const VuDevIface vuiface =3D {
>>      .get_features =3D vubr_get_features,
>>      .set_features =3D vubr_set_features,
>>      .process_msg =3D vubr_process_msg,
>>      .queue_set_started =3D vubr_queue_set_started,
>> +    .queue_resume_to_used =3D vubr_queue_resume_to_used,
>>  };
>>
>>  static void
>> --
>> 2.14.1.146.gd35faa819
>



--=20
Marc-Andr=C3=A9 Lureau
