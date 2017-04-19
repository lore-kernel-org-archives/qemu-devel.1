Received: from eggs.gnu.org ([2001:4830:134:3::10]:44676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0lrJ-0005ZP-Td
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0lrI-0004eo-HZ
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:25:09 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:36661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1d0lrI-0004eL-Ci
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 05:25:08 -0400
Received: by mail-qt0-x233.google.com with SMTP id g60so14167575qtd.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 02:25:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-f1P4OW+DwLRn1AZQCzoiWNX_8Rhq0oduppMOSLWo9Ww@mail.gmail.com>
References: <CAJy91CZpAiZ6adPmbAESrYqDgtK37CEgw4SAk97jCNduADy6Tw@mail.gmail.com>
	<CAFEAcA-V3BNcrhhnap+Hn8spfZPd0=Dv2v0P5myGwqU2e5t0Eg@mail.gmail.com>
	<CAJy91Ca2FTvBzd2OqQZyEJBtCAxxosdcAFP1RMgGCQe2PJXEJA@mail.gmail.com>
	<CAFEAcA-f1P4OW+DwLRn1AZQCzoiWNX_8Rhq0oduppMOSLWo9Ww@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Wed, 19 Apr 2017 11:25:07 +0200
Message-ID: <CAJy91CY=s2H0VYYuDUrs=HYTEKjKZHpU1MXrhStxGxxWg=hfEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Hight Processor time of Socket communciation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 April 2017 at 11:15, Peter Maydell <peter.maydell@linaro.org> wrote:

> On 19 April 2017 at 09:56, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> > Do you mean that it is reasonable for QEMU emulation consumes high CPU
> time
> > when doing host-guest interaction, since the interaction calls many QEMU
> > codes in the background?
>
> > Since my guest app is rather simple and no while() is included,
> according to
> > your words,
> > can I conclude that the high processor time is cause by the callbacks for
> > guest to host data transfer?
>
> What is happening is that the guest kernel's serial driver
> has a loop that (simplified) looks like this:
>
>   do {
>       if (pl011_read(REG_FR) & FR_TXFF)
>           break; /* fifo full, try again later */
>       pl011_write(buffer[x], REG_DR);  /* send one byte */
>       x++;
>   } while (x != len);
>
> This is a lot of guest CPU instructions (and two callouts
> to QEMU's device emulation) for every single byte.
>
> Hi, no, I am not using any kernel driver and I only test the guest to host
data transfer.
I need the kernel transparent guest-host communication.
The code is in this way.
/***************************************************************/*
int main() {
const char *filename = "image_set/Snake_River_(5mb).jpg";
 /* get the file size */
 struct stat buf;
 uint32_t zero = stat(filename, &buf);
 if (zero == 0)
  printf("image size = %d \n", buf.st_size);
 else
  printf("stat() failed");
 /* open the file */
 uint32_t fd = open(filename, O_RDONLY);
 if(!fd){
  printf("could not open file.\n");
  close(fd);
  return 0;
 }
/* read file into s */
 while((ret_in = read(fd, &s[0], BUF_SIZE)) > 0){
  write_to_uart(s, ret_in);
 }
}

/*
 * write_to_uart(): write data to serial port
 */
void write_to_uart(char* out, uint32_t writeSize){
 int i;
 for(i=0; i<writeSize; i++){
  *UART1 =(unsigned char)(*(out+i));
 }
}

regards,
Huan


> >> You will likely get better throughput if you use the 'virt' board
> >> where you can use the virtio-serial device which can send
> >> data more efficiently.
>
> > Here, can I understand your statement in this way,
> > a transmit buffer in the serial device for guest to host data transfer
> > may reduce the processor time, and in turn, increase the throughput?
>
> The reason virtio-serial is faster is because the guest
> kernel driver can essentially tell QEMU
>  "the data is in guest memory at address X length L"
> and then QEMU takes all that data at once. This is much
> more efficient.
>
> thanks
> -- PMM
>
