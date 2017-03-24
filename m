Received: from eggs.gnu.org ([2001:4830:134:3::10]:49112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1crM13-0007zF-L1
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1crM12-0007Gd-MF
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:00:17 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1crM12-0007GX-Hb
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:00:16 -0400
Received: by mail-qt0-x242.google.com with SMTP id x35so1163690qtc.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 03:00:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91Ca+=vJtXn6dV-awqz8xKHNyAnAw0MY91Fbr9yOE2-NNPw@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
	<1322109813.6444955.1490172025040.JavaMail.zimbra@redhat.com>
	<CAJy91CaUxFHJeGLLW4DqK6sBwx2qDnE9s20ZbdT86JDn8yQoHg@mail.gmail.com>
	<218df442-1a31-e969-32ef-01184fae84c0@redhat.com>
	<CAJy91CbBV97RRKr=Rze5-eYrYAvnwiDZQ0oQZi33aKR1v-UXKg@mail.gmail.com>
	<2d7a5a9a-8a7b-1bae-feb8-80fc4ee3048a@redhat.com>
	<CAJy91CbcV3_jVg9PTD6unka6_M65rgkKDv0KsBK=YpVd=XKqvg@mail.gmail.com>
	<ed9e6d65-ba93-d572-861a-46926a37d42a@redhat.com>
	<CAJy91CYfOUZ+_TrN6-tLtWuPX-3_gRc7bfNa4anW0iM42i1FTg@mail.gmail.com>
	<d355d12a-9f37-b7ca-aab0-1fcd0d481a8f@redhat.com>
	<CAJy91Ca+=vJtXn6dV-awqz8xKHNyAnAw0MY91Fbr9yOE2-NNPw@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Fri, 24 Mar 2017 11:00:14 +0100
Message-ID: <CAJy91Cbxh8kG=76EJFHXAd+qbCH-Gx+V8-C9O7b3ytm2XNzPEw@mail.gmail.com>
Content-Type: multipart/mixed; boundary=001a113d0ce66f0c71054b770fd5
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

--001a113d0ce66f0c71054b770fd5
Content-Type: text/plain; charset=UTF-8

Hi, now it is working with the following char-pipe_new.c.

See the patch. Doing the "if fifo has space" polling only when there are
data on the pipe, and next reading from pipe.
The sub_thread does these three things, and the main thread only does
writing to UART fifo when the subthread signalled its handler.

It is working in my case to transfer large data. Rational? Please check.

On 24 March 2017 at 08:24, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:

> Hi, here are the patch files for char-pipe.c, char-win.c, char-win.h
>
>
> On 23 March 2017 at 18:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>>
>>
>> On 23/03/2017 18:28, Jiahuan Zhang wrote:
>> > Hi, the method doesn't work for pipe. It still causes the same issue.
>> > The only difference is that the first byte in the UART fifo can be read
>> > by the guest app.
>> > So now my guest app can immediately read 17bytes when the host is
>> > sending data continuously,
>> > then guest app is unable to read.
>> >
>> > Now there is a solution-to-be. Set the qemu pipe chardev to wait for 1
>> > millisecond before do a next ReadFile(),
>> > then the pl011 can deliver the complete large data by the 16-byte fifo
>> > continuously to the guest app.
>> >
>> > Is it rational? Or is this host -CPU-dependent?
>>
>> Post the patch, maybe you have a bug.
>>
>> Paolo
>>
>
>

--001a113d0ce66f0c71054b770fd5
Content-Type: application/octet-stream; name="char-pipe_new.patch"
Content-Disposition: attachment; filename="char-pipe_new.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0nni1x83

LS0tIGNoYXItcGlwZS5jCTIwMTctMDMtMjQgMDg6MDg6MTMuOTk5MjM3MDAwICswMTAwCisrKyBj
aGFyLXBpcGVfbmV3LmMJMjAxNy0wMy0yNCAxMDo1MjoyMS40NDEzMjIxMDAgKzAxMDAKQEAgLTM1
LDYgKzM1LDYxIEBACiAjZGVmaW5lIE1BWENPTk5FQ1QgMQ0KICNkZWZpbmUgTlRJTUVPVVQgNTAw
MA0KIA0KK3N0YXRpYyBEV09SRCBXSU5BUEkgd2luX2Nocl9waXBlX3RocmVhZChMUFZPSUQgcGFy
YW0pDQorew0KKyAgICBDaGFyZGV2ICpjaHIgPSBDSEFSREVWKHBhcmFtKTsNCisgICAgV2luQ2hh
cmRldiAqcyA9IFdJTl9DSEFSREVWKHBhcmFtKTsNCisgICAgRFdPUkQgc2l6ZTsNCisNCisgICAg
aW50IHJldDsNCisNCisgICAgWmVyb01lbW9yeSgmcy0+b3JlY3YsIHNpemVvZihzLT5vcmVjdikp
Ow0KKyAgICBzLT5vcmVjdi5oRXZlbnQgPSBzLT5ocmVjdjsNCisJd2hpbGUgKDEpIHsNCisNCisJ
CVBlZWtOYW1lZFBpcGUocy0+aGNvbSwgTlVMTCwgMCwgTlVMTCwgJnNpemUsIE5VTEwpOw0KKwkJ
aWYgKHNpemU+MCkgew0KKwkJCS8vIFdhaXQgZm9yIG9uZSBieXRlDQorCQkJd2hpbGUoIShxZW11
X2Nocl9iZV9jYW5fd3JpdGUoY2hyKSkpOw0KKwkJCXJldCA9IFJlYWRGaWxlKHMtPmhjb20sICZz
LT53aW5fcGlwZV9idWYsIDEsICZzaXplLCAmcy0+b3JlY3YpOw0KKwkJCXByaW50ZigiCQkJJXMg
YnVmID0gJWMgc2l6ZSA9ICVsdVxuIiwgX19mdW5jX18sIHMtPndpbl9waXBlX2J1Ziwgc2l6ZSk7
DQorDQorCQkJaWYgKCFyZXQpIHsNCisJCQkJYnJlYWs7DQorCQkJfQ0KKwkJCWlmICghc2l6ZSkg
ew0KKwkJCQlicmVhazsNCisJCQl9DQorDQorCQkJLy8gU29tZSB0ZXJtaW5hbCBlbXVsYXRvciBy
ZXR1cm5zIFxyXG4gZm9yIEVudGVyLCBqdXN0IHBhc3MgXG4NCisJCQlpZiAocy0+d2luX3BpcGVf
YnVmID09ICdccicpIHsNCisJCQkJIGNvbnRpbnVlOw0KKwkJCX0NCisNCisJCQkvLyBTaWduYWwg
dGhlIG1haW4gdGhyZWFkIGFuZCB3YWl0IHVudGlsIHRoZSBieXRlIHdhcyBlYXRlbg0KKwkJCWlm
ICghU2V0RXZlbnQocy0+aHBpcGVJbnB1dFJlYWR5RXZlbnQpKSB7DQorCQkJCSBicmVhazsNCisJ
CQl9DQorCQkJcHJpbnRmKCIJCQklcyB0aGUgbWFpbiB0aHJlYWQgaXMgc2lnbmFsZWRcbiIsIF9f
ZnVuY19fKTsNCisJCQlpZiAoV2FpdEZvclNpbmdsZU9iamVjdChzLT5ocGlwZUlucHV0RG9uZUV2
ZW50LCBJTkZJTklURSkgIT0gV0FJVF9PQkpFQ1RfMCkgew0KKwkJCQkgYnJlYWs7DQorCQkJfQ0K
KwkJCXByaW50ZigiCQkJJXMgdGhlIGJ5dGUgd2FzIGVhdGVuXG4iLCBfX2Z1bmNfXyk7DQorCQl9
DQorCX0NCisgICAgcWVtdV9kZWxfd2FpdF9vYmplY3Qocy0+aHBpcGVJbnB1dFJlYWR5RXZlbnQs
IE5VTEwsIE5VTEwpOw0KKyAgICByZXR1cm4gMDsNCit9DQorDQorc3RhdGljIHZvaWQgd2luX3Bp
cGVfdGhyZWFkX3dhaXRfZnVuYyh2b2lkICpvcGFxdWUpDQorew0KKyAgICBDaGFyZGV2ICpjaHIg
PSBDSEFSREVWKG9wYXF1ZSk7DQorICAgIFdpbkNoYXJkZXYgKnMgPSBXSU5fQ0hBUkRFVihvcGFx
dWUpOw0KKw0KKwlxZW11X2Nocl9iZV93cml0ZShjaHIsICZzLT53aW5fcGlwZV9idWYsIDEpOw0K
KwlTZXRFdmVudChzLT5ocGlwZUlucHV0RG9uZUV2ZW50KTsgLy9mb3JjZSB0aGUgYnl0ZSBpcyBl
YXRlbiBieSB0aGUgZmlmbw0KKwl9DQorfQ0KIHN0YXRpYyBpbnQgd2luX2Nocl9waXBlX2luaXQo
Q2hhcmRldiAqY2hyLCBjb25zdCBjaGFyICpmaWxlbmFtZSwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQpAQCAtOTQsOCArMTQ5LDM4IEBACiAgICAgICAg
IG92LmhFdmVudCA9IE5VTEw7DQogICAgIH0NCiANCi0gICAgcWVtdV9hZGRfcG9sbGluZ19jYih3
aW5fY2hyX3BpcGVfcG9sbCwgY2hyKTsNCi0gICAgcmV0dXJuIDA7DQorICAgICAvLyBmb3IgaW50
ZXJsb2NraW5nDQorICAgIERXT1JEICAgZHdJZDsNCisNCisNCisgICAgcy0+aHBpcGVJbnB1dFJl
YWR5RXZlbnQgPSBDcmVhdGVFdmVudChOVUxMLCBGQUxTRSwgRkFMU0UsIE5VTEwpOw0KKyAgICBz
LT5ocGlwZUlucHV0RG9uZUV2ZW50ICA9IENyZWF0ZUV2ZW50KE5VTEwsIEZBTFNFLCBGQUxTRSwg
TlVMTCk7DQorICAgIGlmIChzLT5ocGlwZUlucHV0UmVhZHlFdmVudCA9PSBJTlZBTElEX0hBTkRM
RV9WQUxVRQ0KKyAgICAgICAgfHwgcy0+aHBpcGVJbnB1dERvbmVFdmVudCA9PSBJTlZBTElEX0hB
TkRMRV9WQUxVRSkgew0KKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiY2Fubm90IGNyZWF0ZSBl
dmVudCIpOw0KKyAgICAgICAgZ290byBlcnIyOw0KKyAgICB9DQorDQorICAgIGlmIChxZW11X2Fk
ZF93YWl0X29iamVjdChzLT5ocGlwZUlucHV0UmVhZHlFdmVudCwgd2luX3BpcGVfdGhyZWFkX3dh
aXRfZnVuYywgY2hyKSkgew0KKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAicWVtdV9hZGRfd2Fp
dF9vYmplY3Q6IGZhaWxlZCIpOw0KKyAgICAgICAgZ290byBlcnIyOw0KKyAgICB9DQorDQorICAg
IHMtPmhwaXBlSW5wdXRUaHJlYWQgPSBDcmVhdGVUaHJlYWQoTlVMTCwgMCwgd2luX2Nocl9waXBl
X3RocmVhZCwgY2hyLCAwLCAmZHdJZCk7DQorICAgIGlmIChzLT5ocGlwZUlucHV0VGhyZWFkID09
IElOVkFMSURfSEFORExFX1ZBTFVFKSB7DQorICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJjYW5u
b3QgY3JlYXRlIHN0ZGlvIHRocmVhZCIpOw0KKyAgICAgICAgZ290byBlcnIzOw0KKyAgICB9DQor
DQorICAgICByZXR1cm4gMDsNCisNCitlcnIzOg0KKyAgICBxZW11X2RlbF93YWl0X29iamVjdChz
LT5ocGlwZUlucHV0UmVhZHlFdmVudCwgTlVMTCwgTlVMTCk7DQorICAgIHJldHVybiAtMTsNCitl
cnIyOg0KKyAgICBDbG9zZUhhbmRsZShzLT5ocGlwZUlucHV0UmVhZHlFdmVudCk7DQorICAgIENs
b3NlSGFuZGxlKHMtPmhwaXBlSW5wdXREb25lRXZlbnQpOw0KKyAgICByZXR1cm4gLTE7DQogDQog
IGZhaWw6DQogICAgIHJldHVybiAtMTsNCg==
--001a113d0ce66f0c71054b770fd5--
