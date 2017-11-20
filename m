Received: from eggs.gnu.org ([2001:4830:134:3::10]:39290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eGtvB-00051M-Tr
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gandalf.corvotempesta@gmail.com>) id 1eGtvA-0001u9-Te
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 16:48:05 -0500
MIME-Version: 1.0
In-Reply-To: <d52519be-e4d7-1324-736d-f36c321f3924@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
	<5b6f8758-5e3e-e759-1592-2768eb85b322@redhat.com>
	<CAJH6TXgrOWxP7jFg98_jv-R1nrFKOXBQA6pPxbkzGWTVW=EReA@mail.gmail.com>
	<CAJH6TXg7eCiqH+3Wq=-QEH3xFhJJekTXm+c1F5w7BebiQGni8A@mail.gmail.com>
	<d8b9ba38-f39a-9b79-ac89-64e9ab3e6a33@redhat.com>
	<04518567-9905-c22c-78f8-ea9dcde7e7ac@redhat.com>
	<CAJH6TXjZMN9msT5sTHLcgFtfgR2bxPVCr2C7ndpnzWdHG0CfqA@mail.gmail.com>
	<d52519be-e4d7-1324-736d-f36c321f3924@redhat.com>
From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date: Mon, 20 Nov 2017 22:48:00 +0100
Message-ID: <CAJH6TXgenK5dN1t7s69vvSLOz0vZsgBD6JuNBx05nmjU13OGMA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="94eb2c0b8076513388055e710a9b"
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

--94eb2c0b8076513388055e710a9b
Content-Type: text/plain; charset="UTF-8"

I did something different, that will build a raw image directly from a
xenserver export, on the fly.
Compared the resulting file (via MD5) with xenmygrate.py and there is a match.

Currently, this is the faster way to convert a XenServer image to a
raw file. Don't need to wait
for export, tar extract and conversion. It does all of that, at the
same time during the VM export in a single pass.

If someone interested in testing it, it would be apreciated.

2017-11-16 15:02 GMT+01:00 Max Reitz <mreitz@redhat.com>:
> On 2017-11-16 11:08, Gandalf Corvotempesta wrote:
>> 2017-11-15 23:55 GMT+01:00 Max Reitz <mreitz@redhat.com>:
>>> https://xanclic.moe/convert-xva.rb -- does this work?
>>> (It seems to works on the two example images I found...)
>>>
>>> An example is in the code, you use it like this:
>>>
>>> $ ./convert-xva.rb ~/Downloads/stats-appliance-2.36.020502.xva Ref:73
>>
>>
>> It doesn't work on huge images:
>>
>> # time convert-xva.rb 20171115_193814_efff_.xva Ref:10 -O qcow2 disk1.qcow2
>> /usr/bin/convert-xva.rb:119:in `exec': Argument list too long -
>> qemu-img (Errno::E2BIG)
>> from /usr/bin/convert-xva.rb:119:in `<main>'
>>
>> real 9m41.414s
>> user 0m19.280s
>> sys 0m3.260s
>
> Well, there is this:
>
> https://github.com/XanClic/qemu.rb/blob/master/examples/convert-xva-online.rb
>
> That should get around that restriction, but currently it is stupidly
> slow (because it just issues all 1 MB copy operations simultaneously),
> and it doesn't use qemu-img convert.  Instead, it uses a real qemu with
> block jobs.  Ideally, you'd use it like this:
>
> $ ./convert-xva-online.rb ~/Downloads/stats-appliance-2.36.020502.xva
> Ref:73      81936 M
> $ qemu-img create -f qcow2 [whatever options you need] disk1.qcow2 \
>     81936M
> Formatting 'disk1.qcow2', fmt=qcow2 size=85916123136 encryption=off
> cluster_size=65536 lazy_refcounts=off refcount_bits=16
> $ ./convert-xva-online.rb ~/Downloads/stats-appliance-2.36.020502.xva \
>     Ref:73 \
>     '{"driver":"qcow2",
>       "detect-zeroes":"unmap",
>       "discard":"unmap",
>       "file":{"driver":"file","filename":"disk1.qcow2"}}'
> Adding block devices...
> Starting block jobs...
> 100.00 % of jobs completed
>
> (Maybe I can get it faster.)
>
> Max
>

--94eb2c0b8076513388055e710a9b
Content-Type: application/x-sh; name="xva_conv.sh"
Content-Disposition: attachment; filename="xva_conv.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ja8q0qku1

IyEvYmluL2Jhc2gKIwojIChjKSAyMDE3IEdVRVNULml0IHMuci5sLiAtIEFsZXNzYW5kcm8gQ29y
YmVsbGkKIyBMaWNlbnNlOiBHUEwKIwojIFNhbXBsZSB1c2FnZToKIyB3Z2V0IC0taHR0cC11c2Vy
PXggLS1odHRwLXBhc3N3b3JkPXkgaHR0cDovL3lvdXIueGVuLnNlcnZlci5ob3N0L2V4cG9ydD91
dWlkPTxWTV9VVUlEPiAtTyAtIHwgdGFyIC0tdG8tY29tbWFuZD0uL3h2YV9jb252LnNoIC14ZiAt
CiMKClRNUF9MQVNUTkFNRV9QUkVGSVg9Ii90bXAvbGFzdG5hbWUiCgppZiBbICIke1RBUl9GSUxF
VFlQRX0iICE9ICJmIiBdOyB0aGVuCiAgIGV4aXQKZmkKCmlmIFtbICIke1RBUl9GSUxFTkFNRX0i
ID1+ICJjaGVja3N1bSIgfHwgIiR7VEFSX0ZJTEVOQU1FfSIgPT0gIm92YS54bWwiIF1dOyB0aGVu
CiAgIGV4aXQKZmkKCkRJU0tOQU1FPSR7VEFSX0ZJTEVOQU1FJS8qfQpGSUxFTkFNRT0ke1RBUl9G
SUxFTkFNRSMqL30KQ1VSTlVNQkVSPSR7RklMRU5BTUUjIiR7RklMRU5BTUUlJVshMF0qfSJ9Cgoj
IEZpcnN0IGZpbGUgPyBUTVBfTEFTVE5BTUUgc2hvdWxkIGJlIGVtcHR5CmlmIFsgISAtZiAiJHtU
TVBfTEFTVE5BTUVfUFJFRklYfV8ke0RJU0tOQU1FfSIgXTsgdGhlbgogICBlY2hvICR7Q1VSTlVN
QkVSfSA+ICR7VE1QX0xBU1ROQU1FX1BSRUZJWH1fJHtESVNLTkFNRX0KCiAgIGNhdCA+ICR7RElT
S05BTUV9LnJhdyAKZWxzZQogICBMQVNUTlVNPSQoY2F0ICR7VE1QX0xBU1ROQU1FX1BSRUZJWH1f
JHtESVNLTkFNRX0pOwoKICAgIyBpcyBzZXF1ZW50aWFsID8KICAgaWYgWyAkKGV4cHIgJHtMQVNU
TlVNfSArIDEpIC1lcSAiJHtGSUxFTkFNRX0iIF07IHRoZW4KICAgICAgY2F0ID4+ICR7RElTS05B
TUV9LnJhdwogICBlbHNlCgkgIGZvciBpIGluICQoc2VxICQoZXhwciAke0xBU1ROVU19ICsgMSkg
JChleHByICR7RklMRU5BTUV9IC0gMSkpOyBkbwogICAgICAgICBkZCBpZj0vZGV2L3plcm8gb2Y9
JHtESVNLTkFNRX0ucmF3IGJzPTFNIGNvdW50PTEgb2ZsYWc9YXBwZW5kIGNvbnY9bm90cnVuYyAy
Pi9kZXYvbnVsbAogICAgICBkb25lCgogICAgICBjYXQgPj4gJHtESVNLTkFNRX0ucmF3CiAgIGZp
CgogICBlY2hvICR7Q1VSTlVNQkVSfSA+ICR7VE1QX0xBU1ROQU1FX1BSRUZJWH1fJHtESVNLTkFN
RX0KZmkK
--94eb2c0b8076513388055e710a9b--
