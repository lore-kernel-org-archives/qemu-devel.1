Received: from eggs.gnu.org ([2001:4830:134:3::10]:53724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d7sJr-00009j-Q1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:44:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d7sJo-0004IV-1s
	for qemu-devel@nongnu.org; Mon, 08 May 2017 19:43:59 -0400
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=MACINTOSH; delsp=yes; format=flowed
Message-Id: <500D3EB0-B49B-4A5E-9D8B-695B8274B003@gmail.com>
Content-Transfer-Encoding: quoted-printable
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 8 May 2017 19:43:51 -0400
Subject: Re: [Qemu-devel] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Here is version two of the floating point test program:

/=20
************************************************************************=20=

**************
  * File: main.c
  * Date: 4-30-2017
  * Description: Implement a test program for various floating point =20
instructions.
  * Note: tests made to work with PowerPC G3 and G5 only.
  * Compiling on Mac OS X: use gcc-3.3 -force_cpusubtype_ALL
  * Note: fsqrt test will not work on PowerPC G3.
  * Version: 2
  =20
************************************************************************=20=

**************/

#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <float.h>
#include <inttypes.h>

// Used to convert unsigned integer <--> double
union Converter
{
     double d;
     uint64_t i;
};

typedef union Converter Converter;

/* Describes the name and description of each bit of the FPSCR */
struct fpscr_info
{
     char name[8];
     char description[100];
};

struct fpscr_info finfo[] =3D
{
     "FX", "Floating-point exception summary",
     "FEX", "Floating-point enabled exception summary",
     "VX", "Floating-point invalid operation exception summary",
     "OX", "Floating-point overflow exception",
     "UX", "Floating-point underflow exception",
     "ZX", "Floating-point zero divide exception",
     "XX", "Floating-point inexact exception",
     "VXSNAN", "Floating-point invalid operation exception for SNaN",
     "VXISI", "Floating-point invalid operation exception for =B0 - =B0",
     "VXIDI", "Floating-point invalid operation exception for =B0/=B0",
     "VXZDZ", "Floating-point invalid operation exception for 0/0",
     "VXIMZ", "Floating-point invalid operation exception for =B0 * 0",
     "VXVC", "Floating-point invalid operation exception for invalid =20
compare",
     "FR", "Floating-point fraction rounded",
     "FI", "Floating-point fraction inexact",
     "FPRF", "Floating-point result class descriptor ",
     "FPRF", "Floating-point less than or negative",
     "FPRF", "Floating-point greater than or positive",
     "FPRF", "Floating-point equal or zero",
     "FPRF", "Floating-point unordered or NaN",
     "NO NAME", "Reserved - you shouldn't be seeing this",
     "VXSOFT", "Floating-point invalid operation exception for =20
software request",
     "VXSQRT", "Floating-point invalid operation exception for =20
invalid square root",
     "VXCVI", "Floating-point invalid operation exception for invalid =20=

integer convert",
     "VE", "Floating-point invalid operation exception enable",
     "OE", "IEEE floating-point overflow exception enable",
     "UE", "IEEE floating-point underflow exception enable",
     "ZE", "IEEE floating-point zero divide exception enable",
     "XE", "Floating-point inexact exception enable",
     "NI", "Floating-point non-IEEE mode",
     "RN", "Rounding bit 0",
     "RN", "Rounding bit 1",
};

// Prints all the FPSCR settings that are set in the input
void print_fpscr_settings(uint32_t fpscr)
{
     int i;
     for (i =3D 0; i < 32; i++) {
         if ((fpscr >> i) & 0x1 =3D=3D 1) {
             /* right description =3D 31 - i  Oddity of IBM =20
documentation */
             printf("bit %d: %s - %s\n", 31-i, finfo[31-i].name, finfo=20=

[31-i].description);
         }
     }
}


#define ZE 27
#define set_fpscr_bit(x) asm volatile ("mtfsb1 %0" : : "i"(x))

/* Keeps track of the number of tests that failed */
int failed_tests =3D 0;

// Reset the FPSCR
void reset_fpscr()
{
     asm volatile("mtfsb0 0");
     asm volatile("mtfsb0 1");
     asm volatile("mtfsb0 2");
     asm volatile("mtfsb0 3");
     asm volatile("mtfsb0 4");
     asm volatile("mtfsb0 5");
     asm volatile("mtfsb0 6");
     asm volatile("mtfsb0 7");
     asm volatile("mtfsb0 8");
     asm volatile("mtfsb0 9");
     asm volatile("mtfsb0 10");
     asm volatile("mtfsb0 11");
     asm volatile("mtfsb0 12");
     asm volatile("mtfsb0 13");
     asm volatile("mtfsb0 14");
     asm volatile("mtfsb0 15");
     asm volatile("mtfsb0 16");
     asm volatile("mtfsb0 17");
     asm volatile("mtfsb0 18");
     asm volatile("mtfsb0 19");
     asm volatile("mtfsb0 20");
     asm volatile("mtfsb0 21");
     asm volatile("mtfsb0 22");
     asm volatile("mtfsb0 23");
     asm volatile("mtfsb0 24");
     asm volatile("mtfsb0 25");
     asm volatile("mtfsb0 26");
     asm volatile("mtfsb0 27");
     asm volatile("mtfsb0 28");
     asm volatile("mtfsb0 29");
     asm volatile("mtfsb0 30");
     asm volatile("mtfsb0 31");

     /* Check if everything is alright */
     uint32_t fpscr;
     Converter c;
     asm volatile("mffs %0" : "=3Df"(c.d));
     fpscr =3D (uint32_t)c.i;
     if (fpscr !=3D 0) {
         printf("Warning: fpscr not equal to zero: 0x%x\n", fpscr);
     }
}

/*
  * The action to take if a test fails
  * Input one: message string
  * Input two: actual fpscr value
  * Input three: expected fpscr value
  * Input four: actual answer
  * Input five: expected answer
  */
  void test_failed(const char *message, uint32_t actual_fpscr, =20
uint32_t expected_fpscr,
                   uint64_t actual_answer, uint64_t expected_answer)
  {
     printf("%s\n", message);
     printf("expected answer: 0x%" PRIx64 " (%f)\n", expected_answer, =20=

expected_answer);
     printf("  actual answer: 0x%" PRIx64 " (%f)\n", actual_answer, =20
actual_answer);
     printf("expected fpscr: 0x%x\n", expected_fpscr);
     printf("  actual fpscr: 0x%x\n", actual_fpscr);

     /* Only print FPSCR bits if there is a difference */
     if (actual_fpscr !=3D expected_fpscr) {
         printf("\nactual FPSCR bits set:\n");
         print_fpscr_settings(actual_fpscr);
         printf("\nexpected FPSCR bits set:\n");
         print_fpscr_settings(expected_fpscr);
     }
     printf("\n");
     failed_tests++;
  }

/*
  * Returns the value of the FPSCR
  * output: unsigned 32 bit integer
  */
uint32_t get_fpscr()
{
     asm volatile("mffs f0");
     asm volatile("stfd f0, 40(r1)");
     uint32_t return_value;
     asm volatile("lwz %0, 44(r1)" : "=3Dr"(return_value));
     return return_value;
}


/* The fpscr and answer have to be right for a test to pass. */


/* Test the fadd instruction */
void test_fadd()
{
     Converter c;
     uint64_t expected_answer =3D 0x3ff3333333333334;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
     reset_fpscr();
     asm volatile("fadd %0, %1, %2" : "=3Df"(c.d) : "f"(0.4), "f"(0.8));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fadd test passed\n");
     } else {
         test_failed("fadd test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fadds instruction */
void test_fadds()
{
     Converter c;
     uint64_t expected_answer =3D 0x407024d500000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
     reset_fpscr();
     asm volatile("fadds %0, %1, %2" : "=3Df"(c.d) : "f"(257.445), =20
"f"(0.857));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fadds test passed\n");
     } else {
         test_failed("fadds test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fsub instruction */
void test_fsub()
{
     Converter c;
     uint64_t expected_answer =3D 0x40f2fd1deb11c6d2;
     uint32_t actual_fpscr, expected_fpscr =3D 0x4000;
     reset_fpscr();
     asm volatile("fsub %0, %1, %2" : "=3Df"(c.d) : "f"(123456.78), =20
"f"(45678.91011));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fsub test passed\n");
     } else {
         test_failed("fsub test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fsubs instruction */
void test_fsubs()
{
     Converter c;
     double expected_answer =3D 0x40884e3d70a3d70a;
     uint32_t actual_fpscr, expected_fpscr =3D 0x4000;
     reset_fpscr();
     asm volatile("fsub %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =20
"f"(456.78));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fsubs test passed\n");
     } else {
         test_failed("fsubs test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test infinity - infinity */
void test_inf_minus_inf()
{
     Converter c;
     uint64_t expected_answer =3D 0x7ff8000000000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0xa0811000;
     reset_fpscr();
     asm volatile("fsub %0, %1, %1" : "=3Df"(c.d) : "f"(INFINITY));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("inf - inf test passed\n");
     } else {
         test_failed("inf - inf test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test division by zero */
void test_division_by_zero()
{
     Converter c;
     uint64_t expected_answer =3D 0x0;
     uint32_t actual_fpscr, expected_fpscr =3D 0xc4000010;
     reset_fpscr();
     set_fpscr_bit(ZE);
     asm volatile("fdiv %0, %1, %2" : "=3Df"(c.d) : "f"(1.0), "f"(0.0));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("division by zero test passed\n");
     } else {
         test_failed("division by zero test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test zero divided by zero */
void test_zero_div_zero()
{
     Converter c;
     uint64_t expected_answer =3D 0x7ff8000000000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0xa0211010;
     reset_fpscr();
     set_fpscr_bit(ZE);
     asm volatile("fdiv %0, %1, %1" : "=3Df"(c.d) : "f"(0.0), "f"(0.0));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("0/0 test passed\n");
     } else {
         test_failed("0/0 test failed", actual_fpscr, expected_fpscr, =20=

c.i, expected_answer);
     }
}

/* Test infinity divided by infinity */
void test_inf_div_inf()
{
     Converter c;
     uint64_t expected_answer =3D 0x7ff8000000000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0xa0411000;
     reset_fpscr();
     asm volatile("fdiv %0, %1, %1" : "=3Df"(c.d) : "f"(INFINITY));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("inf/inf test passed\n");
     } else {
         test_failed("inf/inf test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}


/* Test the fdiv instruction */
void test_fdiv()
{
     Converter c;
     uint64_t expected_answer =3D 0x40059f38ee13b48b;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
     reset_fpscr();
     asm volatile("fdiv %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =20
"f"(456.78));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fdiv test passed\n");
     } else {
         test_failed("fdiv test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fdivs instruction */
void test_fdivs()
{
     Converter c;
     uint64_t expected_answer =3D 0x40059f38e0000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
     reset_fpscr();
     asm volatile("fdivs %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =20
"f"(456.78));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fdivs test passed\n");
     } else {
         test_failed("fdivs test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fmul instruction */
void test_fmul()
{
     Converter c;
     uint64_t expected_answer =3D 0x40365c28f5c28f5c;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
     reset_fpscr();
     asm volatile("fmul %0, %1, %2" : "=3Df"(c.d) : "f"(5.2), "f"(4.3));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fmul test passed\n");
     } else {
         test_failed("fmul test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fmuls instruction */
void test_fmuls()
{
     Converter c;
     uint64_t expected_answer =3D 0x412135a4a0000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
     reset_fpscr();
     asm volatile("fmuls %0, %1, %2" : "=3Df"(c.d) : "f"(1234.56), =20
"f"(456.78));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fmuls test passed\n");
     } else {
         test_failed("fmuls test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fmul instruction */
void test_inf_times_zero()
{
     Converter c;
     uint64_t expected_answer =3D 0x7ff8000000000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0xa0111000;
     reset_fpscr();
     asm volatile("fmul %0, %1, %2" : "=3Df"(c.d) : "f"(INFINITY), =20
"f"(0.0));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("inf * 0 test passed\n");
     } else {
         test_failed("inf * 0 test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fmadd instruction */
void test_fmadd()
{
     Converter c;
     uint64_t expected_answer =3D 0x4123fcaadfa43fe5;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82024000;
     reset_fpscr();
     asm volatile("fmadd %0, %1, %2, %3" : "=3Df"(c.d) : "f"(1234.56), =20=

"f"(456.78), "f"(91011.12));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fmadd test passed\n");
     } else {
         test_failed("fmadd test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fmadds instruction */
void test_fmadds()
{
     Converter c;
     uint64_t expected_answer =3D 0x4123fcaae0000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
     reset_fpscr();
     asm volatile("fmadds %0, %1, %2, %3" : "=3Df"(c.d) : "f"(1234.56), =20=

"f"(456.78), "f"(91011.12));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fmadds test passed\n");
     } else {
         test_failed("fmadds test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fsqrt instruction - This instruction doesn't work on the =20
PowerPC 750 (G3).
    It does work on the PowerPC 970 (G5).  */
/*void test_fsqrt()
{
     double answer;
     reset_fpscr();
     asm volatile("fsqrt %0, %1" : "=3Df"(answer) : "f"(-1.0));
     if (get_fpscr() =3D=3D 0xa0011200) {
         printf("fsqrt test passed\n");
     } else {
         test_failed("fsqrt test failed");
     }
}*/

/* Test an overflow condition */
void test_overflow()
{
     // multiplying two really big numbers equals overflow
     Converter c;
     double really_big_input;
     uint64_t expected_answer =3D 0x7ff0000000000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0x92025000;
     reset_fpscr();
     really_big_input =3D 1.7 * pow(10, 308);
     asm volatile("fmul %0, %1, %1" : "=3Df"(c.d) : =20
"f"(really_big_input));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("overflow test passed\n");
     } else {
         test_failed("overflow test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test an underflow condition */
void test_underflow()
{
     Converter c;
     uint64_t expected_answer =3D 0x199999999999a;
     uint32_t actual_fpscr, expected_fpscr =3D 0x8a074000;
     reset_fpscr();
     asm volatile("fmadd %0, %1, %2, %3" : "=3Df"(c.d) : "f"(DBL_MIN), =20=

"f"(0.1), "f"(0.0));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("underflow test passed\n");
     } else {
         test_failed("underflow test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fctiw instruction */
void test_fctiw()
{
     Converter c;
     uint64_t expected_answer;
     uint32_t actual_fpscr, expected_fpscr;
     double frB;

     /* above maximum value test */
     expected_fpscr =3D 0xa0000100;
     expected_answer =3D 0x7fffffff;
     frB =3D pow(2, 32); // greater than 2^31 - 1
     reset_fpscr();
     asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(frB));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
=20
expected_answer) {
         printf("fctiw above maximum value test passed\n");
     } else {
         test_failed("fctiw above maximum value test failed", =20
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
     }

     /* below minimum value test*/
     expected_fpscr =3D 0xa0000100;
     expected_answer =3D 0x80000000;
     frB =3D -frB;  // less than -2^31
     reset_fpscr();
     asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(frB));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
=20
expected_answer) {
         printf("fctiw below minimum value test passed\n");
     } else {
         test_failed("fctiw below minimum value test failed", =20
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
     }

     /* float to integer test */
     expected_fpscr =3D 0x82060000;
     expected_answer =3D 0xd;
     reset_fpscr();
     asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(12.7));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
=20
expected_answer) {
         printf("fctiw integer conversion test passed\n");
     } else {
         test_failed("fctiw integer conversion test failed", =20
actual_fpscr, expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fctiwz instruction */
void test_fctiwz()
{
     Converter c;
     uint64_t expected_answer;
     uint32_t actual_fpscr, expected_fpscr;
     double frB;

     /* above maximum value test */
     expected_fpscr =3D 0xa0000100;
     expected_answer =3D 0x7fffffff;
     frB =3D pow(2, 32); // greater than 2^31 - 1
     reset_fpscr();
     asm volatile("fctiwz %0, %1" : "=3Df"(c.d) : "f"(frB));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
=20
expected_answer) {
         printf("fctiwz above maximum value test passed\n");
     } else {
         test_failed("fctiwz above maximum value test failed", =20
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
     }

     /* below minimum value test*/
     expected_fpscr =3D 0xa0000100;
     expected_answer =3D 0x80000000;
     frB =3D -frB;  // less than -2^31
     reset_fpscr();
     asm volatile("fctiwz %0, %1" : "=3Df"(c.d) : "f"(frB));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
=20
expected_answer) {
         printf("fctiwz below minimum value test passed\n");
     } else {
         test_failed("fctiwz below minimum value test failed", =20
actual_fpscr, expected_fpscr, (c.i & 0xffffffff), expected_answer);
     }

     /* float to integer test */
     expected_fpscr =3D 0x82060000;
     expected_answer =3D 0x1c;
     reset_fpscr();
     asm volatile("fctiw %0, %1" : "=3Df"(c.d) : "f"(27.98));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && (c.i & 0xffffffff) =3D=3D =
=20
expected_answer) {
         printf("fctiwz integer conversion test passed\n");
     } else {
         test_failed("fctiwz integer conversion test failed", =20
actual_fpscr, expected_fpscr, c.i, expected_answer);
     }
}

/* Test the frsp instruction */
void test_frsp()
{
     Converter c;
     uint64_t expected_answer =3D 0x4271f71fc0000000;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82064000;
     reset_fpscr();
     asm volatile("frsp %0, %1" : "=3Df"(c.d) : =20
"f"(1234567891012.131415));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("frsp test passed\n");
     } else {
         test_failed("frsp test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Test the fnmsub instruction */
void test_fnmsub()
{
     Converter c;
     uint64_t expected_answer =3D 0xc11cdd3cc985f06e;
     uint32_t actual_fpscr, expected_fpscr =3D 0x82028000;
     reset_fpscr();
     asm volatile("fnmsub %0, %1, %2, %3" : "=3Df"(c.d) : "f"(1234.56), =20=

"f"(456.78), "f"(91011.12));
     actual_fpscr =3D get_fpscr();
     if (actual_fpscr =3D=3D expected_fpscr && c.i =3D=3D =
expected_answer) {
         printf("fnmsub test passed\n");
     } else {
         test_failed("fnmsub test failed", actual_fpscr, =20
expected_fpscr, c.i, expected_answer);
     }
}

/* Report the results of all the tests */
void report_results()
{
     if (failed_tests =3D=3D 1) {
         printf("\n=3D=3D=3D Warning: %d test failed =3D=3D=3D\n", =
failed_tests);
     } else if (failed_tests > 1) {
         printf("\n=3D=3D=3D Warning: %d tests failed =3D=3D=3D\n", =
failed_tests);
     } else {
         printf("\n=3D=3D=3D All tests passed =3D=3D=3D\n");
     }
}

int main (int argc, const char * argv[]) {

     test_fadd();
     test_fadds();
     test_fsub();
     test_fsubs();
     test_fmul();
     test_fmuls();
     test_fdiv();
     test_fdivs();
     test_fmadd();
     test_fmadds();
     //test_fsqrt();
     test_inf_minus_inf();
     test_division_by_zero();
     test_zero_div_zero();
     test_inf_div_inf();
     test_inf_times_zero();
     test_overflow();
     test_underflow();
     test_fctiw();
     test_fctiwz();
     test_frsp();
     test_fnmsub();

     report_results();

     return 0;
}


Here are the results of the test program in qemu-system-ppc v 2.9


fadd test failed
expected answer: 0x3ff3333333333334 (1.200000)
   actual answer: 0x3ff3333333333334 (1.200000)
expected fpscr: 0x82064000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fadds test failed
expected answer: 0x407024d500000000 (258.302002)
   actual answer: 0x407024d500000000 (258.302002)
expected fpscr: 0x82064000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fsub test passed
fsubs test passed
fmul test failed
expected answer: 0x40365c28f5c28f5c (22.360000)
   actual answer: 0x40365c28f5c28f5c (22.360000)
expected fpscr: 0x82024000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fmuls test failed
expected answer: 0x412135a4a0000000 (563922.312500)
   actual answer: 0x412135a4a0000000 (563922.312500)
expected fpscr: 0x82024000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fdiv test failed
expected answer: 0x40059f38ee13b48b (2.702745)
   actual answer: 0x40059f38ee13b48b (2.702745)
expected fpscr: 0x82064000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fdivs test failed
expected answer: 0x40059f38e0000000 (2.702745)
   actual answer: 0x40059f38e0000000 (2.702745)
expected fpscr: 0x82024000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fmadd test failed
expected answer: 0x4123fcaadfa43fe5 (654933.436800)
   actual answer: 0x4123fcaadfa43fe5 (654933.436800)
expected fpscr: 0x82024000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fmadds test failed
expected answer: 0x4123fcaae0000000 (654933.437500)
   actual answer: 0x4123fcaae0000000 (654933.437500)
expected fpscr: 0x82064000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

inf - inf test passed
Warning: fpscr not equal to zero: 0x20000000
division by zero test failed
expected answer: 0x0 (0.000000)
   actual answer: 0x7ff0000000000000 (inf)
expected fpscr: 0xc4000010
   actual fpscr: 0xc4005010

actual FPSCR bits set:
bit 27: ZE - IEEE floating-point zero divide exception enable
bit 19: FPRF - Floating-point unordered or NaN
bit 17: FPRF - Floating-point greater than or positive
bit 5: ZX - Floating-point zero divide exception
bit 1: FEX - Floating-point enabled exception summary
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 27: ZE - IEEE floating-point zero divide exception enable
bit 5: ZX - Floating-point zero divide exception
bit 1: FEX - Floating-point enabled exception summary
bit 0: FX - Floating-point exception summary

Warning: fpscr not equal to zero: 0x40000000
0/0 test passed
Warning: fpscr not equal to zero: 0x20000000
inf/inf test passed
Warning: fpscr not equal to zero: 0x20000000
inf * 0 test passed
Warning: fpscr not equal to zero: 0x20000000
overflow test passed
underflow test failed
expected answer: 0x199999999999a (0.000000)
   actual answer: 0x199999999999a (0.000000)
expected fpscr: 0x8a074000
   actual fpscr: 0x88014000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 15: FPRF - Floating-point result class descriptor
bit 4: UX - Floating-point underflow exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 15: FPRF - Floating-point result class descriptor
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 4: UX - Floating-point underflow exception
bit 0: FX - Floating-point exception summary

fctiw above maximum value test failed
expected answer: 0x7fffffff (0.000000)
   actual answer: 0x7fffffff (0.000000)
expected fpscr: 0xa0000100
   actual fpscr: 0xa0011100

actual FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 19: FPRF - Floating-point unordered or NaN
bit 15: FPRF - Floating-point result class descriptor
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

Warning: fpscr not equal to zero: 0x20000000
fctiw below minimum value test failed
expected answer: 0x80000000 (0.000000)
   actual answer: 0x80000000 (0.000000)
expected fpscr: 0xa0000100
   actual fpscr: 0xa0011100

actual FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 19: FPRF - Floating-point unordered or NaN
bit 15: FPRF - Floating-point result class descriptor
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

Warning: fpscr not equal to zero: 0x20000000
fctiw integer conversion test failed
expected answer: 0xd (0.000000)
   actual answer: 0xd (0.000000)
expected fpscr: 0x82060000
   actual fpscr: 0x82000000

actual FPSCR bits set:
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fctiwz above maximum value test failed
expected answer: 0x7fffffff (0.000000)
   actual answer: 0x7fffffff (0.000000)
expected fpscr: 0xa0000100
   actual fpscr: 0xa0011100

actual FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 19: FPRF - Floating-point unordered or NaN
bit 15: FPRF - Floating-point result class descriptor
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

Warning: fpscr not equal to zero: 0x20000000
fctiwz below minimum value test failed
expected answer: 0x80000000 (0.000000)
   actual answer: 0x80000000 (0.000000)
expected fpscr: 0xa0000100
   actual fpscr: 0xa0011100

actual FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 19: FPRF - Floating-point unordered or NaN
bit 15: FPRF - Floating-point result class descriptor
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 23: VXCVI - Floating-point invalid operation exception for =20
invalid integer convert
bit 2: VX - Floating-point invalid operation exception summary
bit 0: FX - Floating-point exception summary

Warning: fpscr not equal to zero: 0x20000000
fctiwz integer conversion test failed
expected answer: 0x1c (0.000000)
   actual answer: 0x1c (0.000000)
expected fpscr: 0x82060000
   actual fpscr: 0x82000000

actual FPSCR bits set:
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

frsp test failed
expected answer: 0x4271f71fc0000000 (1234567954432.000000)
   actual answer: 0x4271f71fc0000000 (1234567954432.000000)
expected fpscr: 0x82064000
   actual fpscr: 0x82004000

actual FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 17: FPRF - Floating-point greater than or positive
bit 14: FI - Floating-point fraction inexact
bit 13: FR - Floating-point fraction rounded
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

fnmsub test failed
expected answer: 0xc11cdd3cc985f06e (-472911.196800)
   actual answer: 0xc11cdd3cc985f06e (-472911.196800)
expected fpscr: 0x82028000
   actual fpscr: 0x82008000

actual FPSCR bits set:
bit 16: FPRF - Floating-point less than or negative
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary

expected FPSCR bits set:
bit 16: FPRF - Floating-point less than or negative
bit 14: FI - Floating-point fraction inexact
bit 6: XX - Floating-point inexact exception
bit 0: FX - Floating-point exception summary


=3D=3D=3D Warning: 18 tests failed =3D=3D=3D
