Received: from eggs.gnu.org ([209.51.188.92]:56898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gzpXL-0001Ne-5w
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gzpOm-00089e-VN
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:08:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gzpOl-00085D-Ut
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 16:08:52 -0500
From: Bandan Das <bsd@redhat.com>
References: <155137665241.44413.528147250140332507.stgit@bahia.lan>
	<CAFEAcA_B4fMvhP+cXhZQX0g5FMq1MvPxcfboT=pDSu9Ww_fFNA@mail.gmail.com>
	<20190301155951.11122086@bahia.lan>
Date: Fri, 01 Mar 2019 16:08:45 -0500
In-Reply-To: <20190301155951.11122086@bahia.lan> (Greg Kurz's message of "Fri,
	1 Mar 2019 15:59:51 +0100")
Message-ID: <jpg7edicnfm.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Greg Kurz <groug@kaod.org> writes:
...
>> 
>> I think there's an underlying problem with this code which we
>> should deal with differently. The 'dataset' local in this
>> file is (I think) pointing at on-the-wire information from
>> the USB device, but we're treating it as an array of
>> host-order uint16_t values. Is this really correct on a
>> big-endian host ?
>
> I don't know much about usb-mtp and the MTP spec says:
>
> https://theta360blog.files.wordpress.com/2016/04/mtpforusb-ifv1-1.pdf
>
> 3.1.1 Multi-byte Data
>
> The standard format for multi-byte data in this specification is
> big-endian. That is, the bits within a byte will be read such that
> the most significant byte is read first. The actual multi-byte data
> sent over the transport may not necessarily adhere to this same
> format, and the actual multi-byte data used on the devices may also
> use a different multi-byte format. The big-endian convention only
> applies within this document, except where otherwise stated.
>
> So I'm not sure about what the code should really do here... :-\
>

If I remember correctly, with USB transport, multibyte values are
little endian and it supersedes the MTP spec? (which is why the code works
as expected on a little endian host). As Peter said, some byte swapping
is probably needed for this to work on big endian hosts.

>> Do we do the right thing if we are
>> passed a malicious USB packet that ends halfway through a
>> utf16_t character, or do we index off the end of the packet
>> data ?
>> 
>
> Can you elaborate ?
>
>> I think that we should define the "filename" field in
>> ObjectInfo to be a uint8_t array, make utf16_to_str()
>> take a uint8_t* for its data array, and have it do the
>> reading of data from the array with lduw_he_p(), which
>> can handle accessing unaligned data.
>> 
>> We should also check what the endianness of other fields in
>> the ObjectInfo struct is (eg "format" and "size" and see
>> whether we should be doing byte swapping here.
>> 
>
> I don't have any idea on that... the code just seems to assume
> everything is host endian.
>
>> PS: it is a bit confusing that in this function the local
>> variable "dataset" is a pointer to a struct of entirely
>> different type to the one that s->dataset is.
>> 
>
> Maybe Gerd or Bandan can comment on that.
>
>> thanks
>> -- PMM
