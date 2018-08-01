Received: from eggs.gnu.org ([2001:4830:134:3::10]:49899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkuOe-0003Jh-N7
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkuOb-0004ub-Le
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:54:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33936 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fkuOb-0004uU-GU
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:54:45 -0400
References: <20180725121311.12867.21729.stgit@pasha-VirtualBox>
	<20180725121701.12867.49392.stgit@pasha-VirtualBox>
	<87y3dxsyq9.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95c71499-e603-4508-c687-f79826414a88@redhat.com>
Date: Wed, 1 Aug 2018 18:54:38 +0200
MIME-Version: 1.0
In-Reply-To: <87y3dxsyq9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 23/24] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net

On 26/07/2018 19:17, Alex Benn=C3=A9e wrote:
>> +
>> +void replay_bh_schedule_oneshot_event(AioContext *ctx,
>> +    QEMUBHFunc *cb,void *opaque)
>> +{
>> +    aio_bh_schedule_oneshot(ctx, cb, opaque);
>> +}
> It seems wrong to have something in stubs that actively does stuff.
> Isn't this meant to be a bunch of NOPs?

No, not necessarily, for example

int64_t cpu_get_clock(void)
{
    return get_clock_realtime();
}

or even

void error_vprintf(const char *fmt, va_list ap)
{
    if (g_test_initialized() && !g_test_subprocess() &&
        getenv("QTEST_SILENT_ERRORS")) {
        char *msg =3D g_strdup_vprintf(fmt, ap);
        g_test_message("%s", msg);
        g_free(msg);
    } else {
        vfprintf(stderr, fmt, ap);
    }
}

Paolo
